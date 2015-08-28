class Quiz < ActiveRecord::Base
  has_and_belongs_to_many :questions
  belongs_to :user

  def get_questions num
    self.questions << Question.order("RANDOM()").take(num)
    # Thing.order("RANDOM()").first
  end

  def get_questions_with_least_answers num
    # Question.includes(:answers).limit(num)
    # Question.includes(:answers)
    least_used_ids = []

    ids = Question.order("RANDOM()").pluck(:id)

    used_question_ids = Answer.pluck(:question_id)
    


    ids.each do |id|
      if used_question_ids.grep(id).size < 1 
        least_used_ids << id
      end
    end

    if least_used_ids.size < num
      counts = Hash.new 0

      used_question_ids.each do |id|
        counts[id] += 1
      end
      counts = shuffle_hash counts

      num_left = num - least_used_ids.size
      values_sorted = counts.values.sort
      values_of_ids_to_add = values_sorted[0..num_left]

      values_of_ids_to_add.each do |number_of_occurences|
        counts.each do |id, count|
          if count == number_of_occurences && least_used_ids.size < num
            least_used_ids << id
          end
        end
      end
    end
    return Question.find(least_used_ids)
  end

  def shuffle_hash hashy
    Hash[hashy.to_a.sample(hashy.length)]
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