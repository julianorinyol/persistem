class Quiz < ActiveRecord::Base
  has_and_belongs_to_many :questions
  belongs_to :user


  def get_questions num
    self.questions << Question.where(user_id: user.id).order("RANDOM()").take(num)
    # Thing.order("RANDOM()").first
  end

  def add_questions_with_least_answers num
    self.questions << get_questions_with_least_answers(num)
  end

  def get_questions_with_least_answers num
    # Question.includes(:answers).limit(num)
    # Question.includes(:answers)
    least_used_ids = []

    ids = Question.where(user_id: user.id).order("RANDOM()").pluck(:id)

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
      counts = Quiz::shuffle_hash counts

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
    self.questions << Question.find(least_used_ids)
  end

  def custom num_questions, params
    # first 2 are exclusive queries, and then popular is an order_by

    if params[:time_ago]
      questions = Question.where(user_id: user.id).send(params[:time_ago]).includes(:note)
    else  
      questions = Question.joins(:note).where(user_id: user.id)
    end
    
    # notebooks is an array of strings
    if params[:notebooks] && params[:notebooks].length > 0 
      # Cant get the godamn query to work:
        #  it works like Question.joins(:note).where('notebook_id = (1,2)')
      # Question.joins(:note).where('notebook_id = ?', params[:notebooks])
      notebook_ids_ints = [];
      params[:notebooks].split(',').each do |id|
        notebook_ids_ints << id.to_i
      end
      results = filter_out_questions_not_in_notebook_array(questions, notebook_ids_ints)
    else 
      results = questions
    end
    
    if params[:popular] && params[:popular] == 'popular'
      results = Question.sort_by_popularity(results)
    end

    correct_num = []

    results.each do|r|
      if correct_num.size < num_questions
        correct_num << r
      end
    end
    self.questions << correct_num
  end

# pass in a joined obj..    questions = Question.joins(:note)
  def filter_out_questions_not_in_notebook_array questions, notebook_ids
    results = []
    questions.each do |q|
      if notebook_ids.index(q.note.notebook_id)  
        results << q
      end
    end
    return results
  end

  def self.shuffle_hash hashy
    Hash[hashy.to_a.sample(hashy.length)]
  end

  # possibly for ajax
  # def ?????????
  #   @answers = []
  #   self.questions.each_with_index do |question, index|
  #     x = Answer.where(user_id: user.id, quiz_id: self.id, question_id: question.id)
  #     if(x.length > 0)
  #       @answers.push({index: index, text: question.text})
  #     end
  #   end
  #   return @answers
  # end
end