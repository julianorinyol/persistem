class Note < ActiveRecord::Base
  # has_and_belongs_to_many :subjects
  belongs_to :user
  has_many :subjects
  has_many :questions


  def is_already_in_db?
    # notes = Note.all

    # notes.each do |note|
    #   if guid == note.guid
    #     return false;
    #   end
    # end
    # return true


    return ( Note.where(guid: guid).empty? ? false : true)
  end  

  def get_content note_store, note
    self.content = note_store.getNoteContent(note.guid)
    self.save
  end
end
