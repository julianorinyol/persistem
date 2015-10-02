class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  delegate :note, :to => :question
  delegate :notebook, :to => :note

  validates :question_id, :text, :user_id, presence: true

end
