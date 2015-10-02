  class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  before_filter :restrict_access
  before_action :set_my_notes_and_notebooks, only: [:index, :show, :initial_sync]
  before_action :set_note_store, only: [:sync, :initial_sync, :initial_sync_content, :count_all_notes, :count_all_notebooks]

  # GET /notes
  # GET /notes.json
  def index
    if @notes.length < 1 && current_user.evernote_auth
      get_all_notebooks
      get_notes_from_evernote 10
      # reset @notes and @notebooks after the query, in case of change..
      @notes = Note.where(user_id: current_user.id)
      @notebooks = Notebook.where(user_id: current_user.id)
    end

    @note = Note.new
    @question = Question.new
    @synced = current_user.synced

    respond_to do |format|
      format.html
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"your-notes\" "
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
    token = session[:authtoken]
    client = EvernoteOAuth::Client.new(token: token)
    
    note_store = client.note_store
    if !@note.content
      @note.get_content(note_store, @note)
    end

    @question = Question.new
    @questions = Question.where(note_id: params[:id].to_i, user_id: current_user.id )
    @synced = current_user.synced
    @answer = Answer.new
  end

  def sync 
    # Using a controlled loop, because not all types of events that cause USN to update on evernote's server's are being captured by my database, so using a loop based on usn, could end up being infinite.
    iterator = 0
    while (iterator < 5) 
      if get_last_usn(@note_store) > current_user.last_usn
        get_filtered_sync_chunk(@note_store)
      end
      iterator += 1
    end
  end
  
# get_filtered_sync_chunk(string authenticationToken,afterUSN, maxEntries,SyncChunkFilter filter)
  def get_filtered_sync_chunk note_store
    sync_chunk_filter = Evernote::EDAM::NoteStore::SyncChunkFilter.new
    sync_chunk_filter.includeNotes = true
    sync_chunk_filter.includeNotebooks = true

      
    updated = note_store.get_filtered_sync_chunk(current_user.last_usn, 5, sync_chunk_filter)

    handle_update(updated, note_store)
  end

  def handle_update updated, note_store 
    if updated.notes && updated.notes.size > 0
      current_user.update_notes(updated.notes, note_store)
    end

    if updated.notebooks && updated.notebooks.size > 0
      Notebook.updateNotebooks(updated.notebooks, current_user)    
    end
  end

  def initial_sync
    if !current_user.synced
      note_filter = Evernote::EDAM::NoteStore::NoteFilter.new
      totalNoteNum = count_all_notes
      
      get_all_notebooks  

      @notes = Note.where(user_id: current_user.id)

      while @notes.size < totalNoteNum
        evernotes = @note_store.findNotes(note_filter, (@notes.size || 0 ) , 1000)
        addNotesToDb(evernotes.notes)
        @notes = Note.where(user_id: current_user.id)
      end
    
      current_user.update(synced: true, last_usn: get_last_usn(@note_store) )
      render json: @notes
    end
  end

  def get_last_usn note_store
      sync_chunk_filter = Evernote::EDAM::NoteStore::SyncChunkFilter.new
      chunk = note_store.get_filtered_sync_chunk(0, 1, sync_chunk_filter)
      return chunk.updateCount
  end

  # AJAX action
  def initial_sync_content
    notes = Note.all
    notes.each do |note|
      note.get_content( @note_store, note )
    end
    render json: Note.all
  end

  def count_all_notes 
    notebookCountsHash = Notebook.get_count_of_notes_by_notebook @note_store
    valuesArr = notebookCountsHash.notebookCounts.values
    valuesArr.inject(:+) #this sums the array
  end

  def count_all_notebooks
    notebookCountsHash = Notebook.get_count_of_notes_by_notebook @note_store
    notebookCountsHash.notebookCounts.values.size
  end

  def get_notes_from_evernote num
    # get all the notes from evernote. 10 at a time.
      token = session[:authtoken]
      client = EvernoteOAuth::Client.new(token: token)
      note_store = client.note_store
      note_filter = Evernote::EDAM::NoteStore::NoteFilter.new
      @first_num_notes =  note_store.findNotes(note_filter, 0, num)

      add_notes_to_db(@first_num_notes.notes)
  end

  def add_notes_to_db notes
    notes.each do |note|
      # if the Note doesn't exist in db, create it.   
      if !Note.where(guid: note.guid).exists?
        nbook = Notebook.where(guid: note.notebookGuid).first
        Note.create(guid: note.guid, title: note.title, user_id: current_user.id, public: false, notebook_guid: note.notebookGuid, notebook_id: nbook.id, update_sequence_number: note.updateSequenceNum )
      else
        # if it is already in db,   update the title, if needed.
        this_note = Note.where(guid: note.guid).first
        if this_note.title != note.title
          this_note.update(title: note.title)
        end
      end
    end
  end

  def get_all_notebooks
      token = session[:authtoken]
      client = EvernoteOAuth::Client.new(token: token)
      note_store = client.note_store
      # totalCount = count_all_notebooks
      @notebooks = note_store.listNotebooks
      add_notebooks_to_db @notebooks
      return @notebooks
  end

  def add_notebooks_to_db notebooks
    notebooks.each do |notebook|
      # if the Note doesn't exist in db, create it.   
      if !Notebook.where(guid: notebook.guid).exists?
        Notebook.create(guid: notebook.guid, title: notebook.name, user_id: current_user.id, update_sequence_number: notebook.updateSequenceNum)
      else
        # if it is already in db,   update the title, if needed.
        this_notebook = Notebook.where(guid: notebook.guid).first
        if this_notebook.title != notebook.name
          this_notebook.update(title: notebook.name, update_sequence_number: notebook.updateSequenceNum)
        end
      end
    end
  end


  private

  
    # Use callbacks to share common setup or constraints between actions.
    def set_note
        @note = Note.find(params[:id])
        rescue ActiveRecord::RecordNotFound
        redirect_to notes_path
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_params
      params[:note]
      params.require(:note).permit(:content, :public, :title)
    end
end
