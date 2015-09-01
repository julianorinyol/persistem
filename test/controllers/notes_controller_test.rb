require 'test_helper'

class NotesControllerTest < ActionController::TestCase
  setup do
    @note = notes(:one)
  end

 test "should not be able to get index, if not logged in" do
    get :index
    assert_redirected_to "/sessions/new", "GETTING index, without being logged in, didn't redirect to root_path."
  end

  test "should not be able to show note, if not logged in" do
    get :show, id: @note

    assert_redirected_to "/sessions/new", "showing note, without being logged in, didn't redirect to root_path."
  end

  
end
# ***************DEFAULT CODE**********************************
  # test "should get index" do
  #   get :index
  #   assert_response :success
  #   assert_not_nil assigns(:notes)
  # end

  # test "should get new" do
  #   get :new
  #   assert_response :success
  # end

  # test "should create note" do
  #   assert_difference('Note.count') do
  #     post :create, note: {  }
  #   end

  #   assert_redirected_to note_path(assigns(:note))
  # end

  # test "should show note" do
  #   get :show, id: @note
  #   assert_response :success
  # end

  # test "should get edit" do
  #   get :edit, id: @note
  #   assert_response :success
  # end

  # test "should update note" do
  #   patch :update, id: @note, note: {  }
  #   assert_redirected_to note_path(assigns(:note))
  # end

  # test "should destroy note" do
  #   assert_difference('Note.count', -1) do
  #     delete :destroy, id: @note
  #   end

  #   assert_redirected_to notes_path
  # end
