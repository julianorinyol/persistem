class Quiz < ActiveRecord::Base
  has_and_belongs_to_many :questions
  belongs_to :user


  def get_questions num
    self.questions << Question.order("RANDOM()").take(num)
    # Thing.order("RANDOM()").first
  end

  def add_questions_with_least_answers num
    self.questions << get_questions_with_least_answers(num)
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
    self.questions << Question.find(least_used_ids)
  end

  def custom num_questions, params
    #variables
      #time_ago
      # popular
      #notebooks

    # first 2 are exclusive queries, and then popular is an order_by

    if params[:time_ago]
      questions = Question.send(params[:time_ago]).includes(:note)
    else  
      questions = Question.joins(:note)
    end
    
    # notebooks is an array of strings
    if params[:notebooks]
      # Cant get the godamn query to work:
        #  it works like Question.joins(:note).where('notebook_id = (1,2)')
      # Question.joins(:note).where('notebook_id = ?', params[:notebooks])
      results = filter_out_questions_not_in_notebook_array(questions, params[:notebooks])
    end
# q = Quiz.create(user_id: 1)
# params = {notebooks: [1,2]}
#  q.custom(7, params)



    if params[:popular] && params[:popular] == 'popular'
      results = results.sort_by_popularity 
    end

# how to use .send  with an array of functions to chain together???
    # Question.send

    return results
    binding.pry
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


  def test_set_times
    questions = Question.all
    questions.each do |q|
      q.update(created_at: (Time.now - rand(1..100).days) )
    end
  end

end