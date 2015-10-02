class User < ActiveRecord::Base
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

end
