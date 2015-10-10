class Notebook < ActiveRecord::Base
  belongs_to :user
  has_many :notes#, inverse_of: :notebook
  has_many :questions, through: :notes 
  has_many :answers, through: :questions

  validates :guid, :title, :user_id, :update_sequence_number, presence: true

  def self.updateNotebooks(notebooks, current_user)
    notebooks.each do |notebook|
      n = Notebook.where(guid: notebook.guid).first
      if !n
        n = Notebook.new(user_id: current_user.id, guid: notebook.guid)
      end
      n.update(title: notebook.name, update_sequence_number: notebook.updateSequenceNum)
      current_user.update(last_usn: notebook.updateSequenceNum)
    end 
  end
  def self.get_count_of_notes_by_notebook note_store
    note_filter = Evernote::EDAM::NoteStore::NoteFilter.new
    return note_store.findNoteCounts(note_filter, false)
  end
end
