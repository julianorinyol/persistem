class Quiz < ActiveRecord::Base
  has_and_belongs_to_many :questions
  belongs_to :user

  def get_questions num
    self.questions << Question.take(num)
  end
end