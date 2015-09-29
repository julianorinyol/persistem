class User < ActiveRecord::Base
  has_secure_password
# added inverse_of so that the associations could be validated on the dependant classes..
  has_many :notes#, inverse_of: :user
  has_many :quizzes
  has_many :notebooks
  has_many :questions
  has_many :answers

  validates :email, presence: true
  validates :email, uniqueness: true
  validates :firstname, presence: true

  # validates :evernote_auth, uniqueness: true
  validates :lastname, presence: true

  validates :password, length: { in: 6..20 }, on: :create
end
