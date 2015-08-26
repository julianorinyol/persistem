class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  before_filter :restrict_access

  # GET /notes
  # GET /notes.json
  def index
    # if(!current_user)
    #   redirect_to 'sessions', action: :create
    #   return
    # end


    @notes = Note.where(public: true)
    if current_user
      @my_notes = Note.where(user_id: current_user.id)

      if @my_notes.length < 4 && current_user.evernote_auth
        getNotesFromEvernote
      end
      @my_notes = Note.where(user_id: current_user.id)

    end
    @note = Note.new
    @question = Question.new

   


    respond_to do |format|
      format.html
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"your-notes\" "
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end

  def sync
    # @notebooks = getAllNotebooksForUser
    # binding.pry
    # @notebooks.each do |notebook|
    #   getAllNotesForNoteBook(notebook)
    # end


      token = session[:authtoken]
      client = EvernoteOAuth::Client.new(token: token)
      note_store = client.note_store
      note_filter = Evernote::EDAM::NoteStore::NoteFilter.new
      evernotes = note_store.findNotes(token, note_filter, 0, 1000)
      addNotesToDb(evernotes.notes)

      @my_notes = Note.where(user_id: current_user.id)
      render json: @my_notes
    # respond_to do |format|
    #   format.json
    #   format.html
    # end
  end

  def getAllNotesForNotebook(notebook)
      token = session[:authtoken]
      client = EvernoteOAuth::Client.new(token: token)
      note_store = client.note_store
      note_filter = Evernote::EDAM::NoteStore::NoteFilter.new
      note_store.findNotes(note_filter)

  end

  # def updateNotesFromEvernote
  #   if session[:authtoken]
  #     token = session[:authtoken]
  #     client = EvernoteOAuth::Client.new(token: token)
  #     note_store = client.note_store
  #     @notebooks = note_store.listNotebooks
  #     note_filter = Evernote::EDAM::NoteStore::NoteFilter.new
  #     @first_10_notes =  note_store.findNotes(note_filter, 0, 10)
  #     getAllNotesForAllNotebooks()

  #     @evernote_notes_contents = []

  #     @first_10_notes.notes.each_with_index do |note, n|
  #       @evernote_notes_contents << note_store.getNoteContent(note.guid)
  #     end
  #   end
  # end

  def getNotesFromEvernote
    # get all the notes from evernote. 10 at a time.
      token = session[:authtoken]
      client = EvernoteOAuth::Client.new(token: token)
      note_store = client.note_store
      @notebooks = note_store.listNotebooks
      note_filter = Evernote::EDAM::NoteStore::NoteFilter.new
      @first_10_notes =  note_store.findNotes(note_filter, 0, 10)

      addNotesToDb(@first_10_notes.notes)
  end

  def addNotesToDb notes
    notes.each do |note|
      # if the Note doesn't exist in db, create it.   
      if !Note.where(guid: note.guid).exists?
        Note.create(guid: note.guid, title: note.title, user_id: current_user.id, public: false)
      else
        # if it is already in db,   update the title, if needed.
        this_note = Note.where(guid: note.guid).first
        if this_note.title != note.title
          this_note.update(title: note.title)
        end
      end
    end
  end

  def updateNotesFromEvernote
  end

  def getAllNotebooksForUser
      token = session[:authtoken]
      client = EvernoteOAuth::Client.new(token: token)
      note_store = client.note_store
      @notebooks = note_store.listNotebooks
  end

  # def getAllNotesForAllNotebooks
    # token = session[:authtoken]
    # client = EvernoteOAuth::Client.new(token: token)
    # note_store = client.note_store
    # @notebooks = note_store.listNotebooks

  #   @arr_of_arrs_of_notes = []

  #   @notebooks.each do |notebook|

  #     note_filter = Evernote::EDAM::NoteStore::NoteFilter.new
  #     note_filter.notebookGuid = notebook.guid
  #     @arr_of_arrs_of_notes << note_store.findNotes(note_filter, 0, 10)
  #   end

  # end


  # GET /notes/1
  # GET /notes/1.json
  def show
     token = session[:authtoken]
    client = EvernoteOAuth::Client.new(token: token)
    
    note_store = client.note_store

    @notes = Note.where(public: true)
    if current_user
      @my_notes = Note.where(user_id: current_user.id)
    end
    if !@note.content
      @note.get_content(note_store, @note)
    end

    @question = Question.new
    @questions = Question.where(note_id: params[:id].to_i )
  end

  # # GET /notes/new
  def new
    @note = Note.new
  end

  # # GET /notes/1/edit
  def edit
    token = session[:authtoken]
    client = EvernoteOAuth::Client.new(token: token)
    
    note_store = client.note_store

    @notes = Note.where(public: true)
    if current_user
      @my_notes = Note.where(user_id: current_user.id)
    end
    if !@note.content
      @note.get_content(note_store, @note)
    end

    @question = Question.new
    @questions = Question.where(note_id: params[:id].to_i )
  end

  # # POST /notes
  # # POST /notes.json
  def create
    @note = Note.new(note_params)
    @note.user = current_user
    respond_to do |format|
      if @note.save
        format.html { redirect_to @note, notice: 'Note was successfully created.' }
        format.json { render :show, status: :created, location: @note }
        # format.html { notice: 'Note was successfully created'}
      else
        format.html { render :new }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end
    
  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to @note, notice: 'Note was successfully updated.' }
        format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_to notes_url, notice: 'Note was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_params
      params[:note]
      params.require(:note).permit(:cntent, :public, :title)
    end
end
