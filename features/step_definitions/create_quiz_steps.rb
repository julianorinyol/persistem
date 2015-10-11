Then(/^i see a random set of questions$/) do
  this_path = current_path
  page.driver.browser.manage.window.resize_to(1024, 768)
  visit this_path
  expect(find_all(".quiz-answer-submit-text").size).to eq 7

  quiz = Quiz.find(current_path[-1])
  # all_questions = sort_by_number_of_dependants(Question.all, "answers").pluck(:id)
  # quiz_questions = quiz.questions.map! {|q| q.id }
  # expect(all_questions[0,7]).not_to eq quiz_questions
  all_smaller = true
  questions = quiz.questions
  questions.each_with_index do |q,i|
    break if i == questions.size - 1
    all_smaller = false if q.answers.size > questions[i + 1].answers.size
  end
  expect(all_smaller).to be false
  # TODO   the test is right, but code isn't implimented...  it's not doing random.. its ordered..
end
