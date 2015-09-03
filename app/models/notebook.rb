class Notebook < ActiveRecord::Base
  belongs_to :user
  has_many :notes


  def self.updateNotebooks(notebooks, current_user)
    notebooks.each do |notebook|
      n = Notebook.where(guid: notebook.guid).first
      if !n
        n = Notebook.create(user_id: current_user.id, guid: notebook.guid)
      end
      n.update(title: notebook.name, update_sequence_number: notebook.updateSequenceNum)
      current_user.update(last_usn: notebook.updateSequenceNum)
    end 
  end

end
