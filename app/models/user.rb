class User < ActiveRecord::Base
  has_secure_password
# added inverse_of so that the associations could be validated on the dependant classes..
  has_many :notes#, inverse_of: :user
  has_many :quizzes
  has_many :notebooks
  has_many :questions
  has_many :answers

  validates :email, presence: true
  validates :email, uniqueness: true
  validates :firstname, presence: true

  # validates :evernote_auth, uniqueness: true
  validates :lastname, presence: true

  validates :password, length: { in: 6..20 }, on: :create

   def update_notes(notes,note_store)
    notes.each do |note|
      n = Note.where(guid: note.guid).first
      if !n
        notebook_id = Notebook.where(guid: note.notebookGuid).first
        n = Note.create(user_id: id, notebook_guid: note.notebookGuid, notebook_id: notebook_id, public: false, guid: note.guid)
      end

      n.update(title: note.title, update_sequence_number: note.updateSequenceNum)
      n.get_content(note_store, n)
      self.update(last_usn: note.updateSequenceNum)
    end
  end

end
