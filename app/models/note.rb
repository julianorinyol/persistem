class Note < ActiveRecord::Base
  # has_and_belongs_to_many :subjects
  belongs_to :user
  has_many :subjects
  has_many :questions





  def getNotes

  end

  def getNotebooks
  
  end

end
