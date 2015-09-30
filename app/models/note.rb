class Note < ActiveRecord::Base
  # has_and_belongs_to_many :subjects
  belongs_to :user
  has_many :subjects
  has_many :questions
  belongs_to :notebook
  has_many :answers, through: :questions
  
  validates :guid, :title, :user_id, :notebook_guid, :notebook_id, :update_sequence_number, presence: true
  validates :public, inclusion: { in: [true, false] }

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

  def self.popular current_user
    notes = Note.where(user_id: current_user.id).includes(:questions)

    counts = Hash.new 0

    notes.each do |note|
      counts[note.id] = { note: note, amount: note.questions.size }
    end
    counts_sorted_by_amount = counts.values.sort_by do |count| count['amount'] end
    most_popular_notes = []
    counts_sorted_by_amount.each do |custom_obj| most_popular_notes << custom_obj[:note] end
    return most_popular_notes
  end
  
end
