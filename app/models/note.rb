class Note < ActiveRecord::Base
  # has_and_belongs_to_many :subjects
  belongs_to :user
  has_many :subjects
  has_many :questions
  belongs_to :notebook

  # scope :popular, -> do where("created_at BETWEEN ? AND ?", Time.zone.now.beginning_of_day, Time.zone.now.end_of_day) end
   # scope :popular, -> do where(self.) end


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
  # def self.popular
  #   notes = Note.includes(:questions)

  #   counts = Hash.new 0

  #   notes.each do |note|
      
  #     counts[note] = note
  #     counts[count] = note.questions.size
  #   end

  # end
end
