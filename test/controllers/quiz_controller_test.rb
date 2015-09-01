require 'test_helper'

class QuizControllerTest < ActionController::TestCase
  test "Quiz should not generate, if not logged in" do
    get :new_least_answered
    assert_redirected_to "/sessions/new", "generated quiz, without being logged in, didn't redirect to root_path."
  end
end
