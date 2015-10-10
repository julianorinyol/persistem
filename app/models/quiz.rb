class Quiz < ActiveRecord::Base
  include SharedMethods

  has_and_belongs_to_many :questions
  belongs_to :user

  validates :user_id, presence: true

  def get_questions num
    self.questions << Question.where(user_id: user.id).order("RANDOM()").take(num)
  end

  def add_questions_with_least_answers num
    self.questions << get_questions_with_least_answers(num)
  end

  def get_questions_with_least_answers num
    questions = user.questions

    least_answered_questions = questions.sort_by do |question|
      question.answers.size
    end
     
    return least_answered_questions[0,7]
  end

  def custom num_questions, params
    # first 2 keys in 'params'(time_ago, notebooks) are exclusive queries, and then 'popular' is an order_by

    if params[:time_ago]
      questions = filter_by_date params[:time_ago]
    else  
      questions = Question.joins(:note).where(user_id: user.id)
    end
    
    if params[:notebooks] && params[:notebooks].length > 0 
      notebook_ids = params[:notebooks].split(',').map do |id|
        id.to_i
      end
      questions = filter_out_questions_not_in_notebook_array(questions, notebook_ids)
    end
    questions = questions.sort_by_number_of("answers")

    if params[:popular] && params[:popular] == 'popular'
      questions.reverse!
    end
    correct_num = []
    questions.each do|r|
      if correct_num.size < num_questions
        correct_num << r
      end
    end
    self.questions << correct_num
  end

  def filter_by_date time_period
    Question.where(user_id: user.id).send(time_period).includes(:note)
  end

  def filter_out_questions_not_in_notebook_array questions, notebook_ids
    results = []
    questions.each do |q|
      if notebook_ids.index(q.note.notebook_id)  
        results << q
      end
    end
    results
  end
end