class User < ActiveRecord::Base
  has_secure_password

  has_many :notes
  has_many :quizzes

  validates :email, presence: true

  validates :firstname, presence: true

  validates :lastname, presence: true

  validates :password, length: { in: 6..20 }, on: :create
end
