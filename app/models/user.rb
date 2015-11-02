class User < ActiveRecord::Base
  include SampleData

  has_secure_password
  has_many :notes#, inverse_of: :user
  has_many :quizzes
  has_many :notebooks
  has_many :questions
  has_many :answers

  validates :email, :firstname, :lastname, presence: true
  validates :email, uniqueness: true

  # validates :evernote_auth, uniqueness: true

  validates :password, length: { in: 6..20 }, on: :create

   def update_notes(evernotes, note_store)
    evernotes.each do |evernote_note|
      note = Note.where(guid: evernote_note.guid).first
      if !note
        notebook_id = Notebook.where(guid: evernote_note.notebookGuid).first.id
        note = Note.create(user_id: id, notebook_guid: evernote_note.notebookGuid, notebook_id: notebook_id, public: false, guid: evernote_note.guid)
      end

      note.update(title: evernote_note.title, update_sequence_number: evernote_note.updateSequenceNum)
      note.get_content(note_store, note)
      self.update(last_usn: evernote_note.updateSequenceNum)
    end
  end

  #******************************
  def initial_sync
    note_filter = Evernote::EDAM::NoteStore::NoteFilter.new
    totalNoteNum = count_all_notes
    get_all_notebooks  

    notes = self.notes

    if !totalNoteNum.nil?
      set_note_store
      while notes.size < totalNoteNum
        evernotes = @note_store.findNotes(note_filter, (notes.size || 0 ) , 1000)
        add_notes_to_db(evernotes.notes)
        notes = self.notes
      end
    end
    update(synced: true, last_usn: get_last_usn(@note_store) )
    notes
  end
  def get_notes_from_evernote num
     # get all the notes from evernote. 10 at a time.
    set_note_store
    note_filter = Evernote::EDAM::NoteStore::NoteFilter.new
    @first_num_notes =  @note_store.findNotes(note_filter, 0, num)
    add_notes_to_db(@first_num_notes.notes)
   end

  def set_note_store
    token = evernote_auth
    client = EvernoteOAuth::Client.new(token: token)
    @note_store = client.note_store
  end

  def count_all_notes 
    set_note_store
    notebookCountsHash = Notebook.get_count_of_notes_by_notebook @note_store
    if notebookCountsHash.notebookCounts
      valuesArr = notebookCountsHash.notebookCounts.values
      return valuesArr.inject(:+) #this sums the array
    end
  end
  def get_all_notebooks
      set_note_store
      # totalCount = count_all_notebooks
      notebooks = @note_store.listNotebooks
      add_notebooks_to_db notebooks
      return notebooks
  end
  def add_notes_to_db notes
    notes.each do |note|
      # if the Note doesn't exist in db, create it.   
      if !Note.where(guid: note.guid).exists?
        nbook = Notebook.where(guid: note.notebookGuid).first
        Note.create(guid: note.guid, title: note.title, user_id: id, public: false, notebook_guid: note.notebookGuid, notebook_id: nbook.id, update_sequence_number: note.updateSequenceNum )
      else
        # if it is already in db,   update the title, if needed.
        this_note = Note.where(guid: note.guid).first
        if this_note.title != note.title
          this_note.update(title: note.title)
        end
      end
    end
  end

   def sync 
    # Using a controlled loop, because not all types of events that cause USN to update on evernote's server's are being captured by my database, so using a loop based on usn, could end up being infinite.
    iterator = 0
    set_note_store
    while (iterator < 5) 
      if get_last_usn(@note_store) > last_usn
        get_filtered_sync_chunk(@note_store)
      end
      iterator += 1
    end
  end

  def sync_all_notes_content
    notes = self.notes
    notes.each do |note|
      note.get_content( @note_store, note )
    end
    return self.notes
  end

  def get_filtered_sync_chunk note_store
    sync_chunk_filter = Evernote::EDAM::NoteStore::SyncChunkFilter.new
    sync_chunk_filter.includeNotes = true
    sync_chunk_filter.includeNotebooks = true
      
    updated = note_store.getFilteredSyncChunk(last_usn, 5, sync_chunk_filter)

    handle_update(updated, note_store)
  end

  def handle_update updated, note_store 
    if updated.notes && updated.notes.size > 0
      update_notes(updated.notes, note_store)
    end

    if updated.notebooks && updated.notebooks.size > 0
      Notebook.updateNotebooks(updated.notebooks, self)    
    end
  end

  def add_notebooks_to_db notebooks
    notebooks.each do |notebook|
      # if the Note doesn't exist in db, create it.   
      if !Notebook.where(guid: notebook.guid).exists?
        Notebook.create(guid: notebook.guid, title: notebook.name, user_id: id, update_sequence_number: notebook.updateSequenceNum)
      else
        # if it is already in db,   update the title, if needed.
        this_notebook = Notebook.where(guid: notebook.guid).first
        if this_notebook.title != notebook.name
          this_notebook.update(title: notebook.name, update_sequence_number: notebook.updateSequenceNum)
        end
      end
    end
  end

  def count_all_notebooks
    notebookCountsHash = Notebook.get_count_of_notes_by_notebook @note_store
    notebookCountsHash.notebookCounts.values.size
  end

  def get_last_usn note_store
      sync_chunk_filter = Evernote::EDAM::NoteStore::SyncChunkFilter.new
      chunk = note_store.getFilteredSyncChunk(0, 1, sync_chunk_filter)
      return chunk.updateCount
  end

  def create_sample_data
    # load data file

    notebook_titles = ["Sample Notebook","Notebook2"]
    new_notebooks =[]
    notebook_titles.each_with_index do |title, index|
      new_notebooks << Notebook.create(title: title, user_id: id, guid: "123abc" + index.to_s, syncable: false, update_sequence_number: 1)
    end

    notes_data = [
      {title:"Sample Note", content: "Hi, Persistem is set up to sync with your evernote account, since we can't seem to find any notes in your evernote account, we've created a few sample notes, notebooks and questions for you to experiment with!", notebook_id: new_notebooks[0].id, notebook_guid: new_notebooks[0].guid, syncable: false, user_id: id, guid: 'ablazzzbla123', update_sequence_number: 1, public: false},
      {title:"Sample Note2", content: "c2", notebook_id: new_notebooks[0].id, notebook_guid: new_notebooks[0].guid, syncable: false, user_id: id , guid: 'ablazzzbla123', update_sequence_number: 1, public: false},
      {title:"Sample Note3", content: "c3", notebook_id: new_notebooks[1].id, notebook_guid: new_notebooks[1].guid, syncable: false, user_id: id, guid: 'ablablazzz123', update_sequence_number: 1, public: false}
    ]
    new_notes = []
    notes_data.each do |n|
      new_notes << Note.create(n)
    end
  end
end
