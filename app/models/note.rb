class Note < ActiveRecord::Base
  # has_and_belongs_to_many :subjects
  belongs_to :user
  has_many :subjects
  has_many :questions


  def is_already_in_db?
    return ( Note.where(guid: guid).empty? ? false : true)
  end  

  def get_content note_store, note
    xml_content = note_store.getNoteContent(note.guid)
    self.content = Note::parseENML(xml_content)
    self.save
  end

  def self.parseENML xml_content
    xml_doc  = Nokogiri::XML(xml_content)
    xml_doc.css("en-note").children.to_s
  end
end
