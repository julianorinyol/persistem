require 'rails_helper'

RSpec.describe NotesController, type: :controller do

  context 'logged in as user' do
    before :each do
      login_as(create(:user))
    end

    describe "GET #index" do
      # Needs to stub any real api calls!
        # Object.any_instance.stub(:NotesController).and_return(:return_value)
      # it "sets @note to a new note" do
      #   NotesController.any_instance.stub(:getAllNotebooks)
      #   NotesController.any_instance.stub(:getNotesFromEvernote)
      # end
      it "sets @question to a new question"
      it "sets @synced to either true or false" do

      end
      # it "starts an ajax call if @synced is false??"
      it "renders :index" do
        NotesController.any_instance.stub(:getAllNotebooks)
        NotesController.any_instance.stub(:getNotesFromEvernote)
        get :index
        expect(@controller).to have_received(:getAllNotebooks)
        expect(response).to render_template :index
      end
      it "sets @note to a new note" do
        NotesController.any_instance.stub(:getAllNotebooks)
        NotesController.any_instance.stub(:getNotesFromEvernote)
      end
      it "sets @question to a new question"
      it "sets @synced to either true or false" 
    end
  end
  context "not logged in" do
    describe "GET #index" do
      it "redirects to new_session_path" do
        get :index
        expect(response).to redirect_to new_session_path
      end
    end
    describe "GET notes/sync/initial/ --> notes#initial_sync"  do
      it "redirects to new_session_path" do
        get :initial_sync
        expect(response).to redirect_to new_session_path
      end
    end
    describe "GET notes#show" do
      # get_note  will redirect to notes_path, which redirects to new_session_path
      it "redirects to notes_path" do
        get :show, id: 1
        expect(response).to redirect_to notes_path
      end
    end 
    describe "GET notes/sync/evernote -> notes#sync" do
      it "redirects to new_session_path" do
        get :sync
        expect(response).to redirect_to new_session_path
      end
    end 
    describe "GET notes/sync/content -> notes#initial_sync_content"  do
      it "redirects to new_session_path" do
        get :initial_sync_content
        expect(response).to redirect_to new_session_path
      end
    end
  end


      #**************************INSTANCE METHODS ******************************************#

    describe "#handleUpdate" do 

    end
    describe "#getFilteredSyncChunk note_store" do 

    end
    describe 'get_last_usn(note_store)' do 
    end
    describe "count_all_notes" do 
    end
    describe "count_all_notebooks" do
    end
    describe "getNotesFromEvernote" do
    end
    describe "addNotesToDb(notes)" do
    end
    describe "set_note" do
    end
    describe "note_params" do 
    end
    


             #            Prefix Verb   URI Pattern                                 Controller#Action

             #               notes GET    /notes(.:format)                            notes#index
             #                note GET    /notes/:id(.:format)                        notes#show
             #  notes_sync_initial GET    /notes/sync/initial(.:format)               notes#initial_sync
             # notes_sync_evernote GET    /notes/sync/evernote(.:format)              notes#sync
             #  notes_sync_content GET    /notes/sync/content(.:format)               notes#initial_sync_content



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
