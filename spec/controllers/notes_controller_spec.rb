require 'rails_helper'

RSpec.describe NotesController, type: :controller do

  context 'logged in as user' do
    before :each do
      login_as(create(:user))
    end

    describe "GET #index" do
      it "sets @note to a new note"
      it "sets @question to a new question"
      it "sets @synced to either true or false" 
      # it "starts an ajax call if @synced is false??"
      it "renders :index" do
        get :index
        expect(response).to render_template :index
      end
    end
  end
  context "not logged in" do

  end


end


# def index
#     if @notes.length < 1 && current_user.evernote_auth
#       getAllNotebooks
#       getNotesFromEvernote
#       # reset @notes and @notebooks after the query, in case of change..
#       @notes = Note.where(user_id: current_user.id)
#       @notebooks = Notebook.where(user_id: current_user.id)
#     end

#     @note = Note.new
#     @question = Question.new
#     @synced = current_user.synced

#     respond_to do |format|
#       format.html
#       format.csv do
#         headers['Content-Disposition'] = "attachment; filename=\"your-notes\" "
#         headers['Content-Type'] ||= 'text/csv'
#       end
#     end
#   end
