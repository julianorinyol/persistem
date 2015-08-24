class Quiz < ActiveRecord::Base
  has_many :questions
  has_many :answers
  belongs_to :user
end