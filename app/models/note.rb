class Note < ActiveRecord::Base
  include SharedMethods
  # has_and_belongs_to_many :subjects
  belongs_to :user
  has_many :subjects
  has_many :questions
  belongs_to :notebook
  has_many :answers, through: :questions
  
  validates :guid, :title, :user_id, :notebook_guid, :notebook_id, :update_sequence_number, presence: true
  validates :public, inclusion: { in: [true, false] }

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
