class Quiz < ActiveRecord::Base
  has_and_belongs_to_many :questions
  belongs_to :user

  def get_questions num
    self.questions << Question.take(num)
  end

  def get_previous_answers
    @answers = []
    self.questions.each_with_index do |question, index|
      x = Answer.where(quiz_id: self.id, question_id: question.id)
      if(x.length > 0)
        @answers.push({index: index, text: question.text})
      end
    end
    return @answers
  end
end