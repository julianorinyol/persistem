module CustomHelpers
  def get_num_of_dependants_for_all parent_class, child_class
    get_num_of_dependants_for_array(Object.const_get(parent_class.titleize).all, child_class).sort
  end

  def get_num_of_dependants_for_array arr, child_class
    num_of_dependants = []
    arr.each do |x|
      num_of_dependants << x.send(child_class).size
    end
    num_of_dependants.sort
  end

  def create_x_many_objects(num, factory)
    num.to_i.times do
      create(factory.to_sym)
    end
  end

  def ensure_each_user_has_at_least_one
    num_users = User.count
    num_notes = Note.count
    num_questions = Question.count
    num_notebooks = Notebook.count
    num_answers = Answer.count
    User.all.each do |user|
      expect(user.notes.size).to be > 0
      expect(user.notebooks.size).to be > 0
      expect(user.questions.size).to be > 0
      expect(user.answers.size).to be > 0
    end
  end
  
  # TODO enable ensure_even_distribution  once fair_share is rewritten

  # def ensure_even_distribution
  #   num_users = User.count
  #   num_notes = Note.count
  #   num_questions = Question.count
  #   num_notebooks = Notebook.count
  #   num_answers = Answer.count
  #   User.all.each do |user|
  #     expect(user.notes.size).to be > fair_share(num_notes, num_users)
  #     expect(user.notebooks.size).to be > fair_share(num_notebooks, num_users)
  #     expect(user.questions.size).to be > fair_share(num_questions, num_users)
  #     expect(user.answers.size).to be > fair_share(num_answers, num_users)
  #   end
  # end

  # ensures that the distribution is actually happening.  Like that each user, at least has SOME of the dependants
  # TODO write a fair_share method that takes into account the number of items it's taking. should work for 2 and 2000
  # def fair_share num, num_users 
  #   if num_users <= 5
  #     percent = ((100 / num_users) - 15).to_f/100
  #   elsif num_users <= 10 
  #     percent = ((100 / num_users) - 8).to_f/100
  #   else 
  #     percent = ((100/num_users).to_f/7)/100
  #   end   
  #   num * percent
  # end

end