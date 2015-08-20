class Question < ActiveRecord::Base
  has_one :note
  has_many :answers
  belongs_to :user
end
