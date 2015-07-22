class Question < ActiveRecord::Base
  belongs_to :note
  has_many :answers
end
