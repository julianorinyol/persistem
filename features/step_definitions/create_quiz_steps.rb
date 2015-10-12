Then(/^i see a random set of questions$/) do
  # capybara & selenium can't seem to find elements that aren't currently shown in the minimized window, so we expand it.
  full_screen

  sleep 3
  expect(find_all(".quiz-answer-submit-text").size).to eq 7

  quiz = Quiz.find(current_path[-1])

  all_smaller = true

  questions = quiz.questions
  questions.each_with_index do |q,i|
    break if i == questions.size - 1
    all_smaller = false if q.answers.size > questions[i + 1].answers.size
  end
  expect(all_smaller).to be false
  # TODO   the test is right, but code isn't implimented...  it's not doing random.. its ordered..
end


Then(/^I should see the (\d+) questions that have the least amount of answers out of all of my questions\.$/) do |num|
  sleep 3
  seven_questions_with_least_answers = Question.all.sort_by_number_of("answers")[0,7]
  quiz = Quiz.find(current_path[-1])
  expect(quiz.questions).to eq seven_questions_with_least_answers

  questions = quiz.questions
  questions.each_with_index do |q,i|
    expect(q.answers.size).to be <= questions[i+1].answers.size unless i == questions.size - 1
  end
end
