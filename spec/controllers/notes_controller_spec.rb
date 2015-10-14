require 'rails_helper'

RSpec.describe NotesController, type: :controller do

  context 'logged in as user' do
    before :each do
      # login_as(create(:user))
    end

    describe "GET #index" do
      # Needs to stub any real api calls!
        # Object.any_instance.stub(:NotesController).and_return(:return_value)
      # it "sets @note to a new note" do
      #   NotesController.any_instance.stub(:get_all_notebooks)
      #   NotesController.any_instance.stub(:get_notes_from_evernote)
      # end
      it "sets @question to a new question" do
        login_as(create(:user))
        User.any_instance.stub(:get_all_notebooks)
        User.any_instance.stub(:get_notes_from_evernote)
        get :index
        expect(assigns["question"].class).to eq Question
      end
      it "sets @synced to either true or false" do

      end
      # it "starts an ajax call if @synced is false??"
      it "renders :index" do
        user = create(:user)
        login_as(user)
        User.any_instance.stub(:get_all_notebooks)
        User.any_instance.stub(:get_notes_from_evernote)
        get :index
        expect(user).to have_received(:get_all_notebooks)
        expect(response).to render_template :index
      end

      it "sets @note to a new note" do
        login_as(create(:user))
        User.any_instance.stub(:get_all_notebooks)
        User.any_instance.stub(:get_notes_from_evernote)
        get :index
        expect(assigns["note"].class).to eq Note
      end
      it "sets @notebooks to the user's notebooks" do
        login_as(create(:user))
        create_x_many_objects 5, "notebook"
        User.any_instance.stub(:get_all_notebooks)
        User.any_instance.stub(:get_notes_from_evernote)
        get :index
        assigns["notebooks"].each do |notebook|
          expect(notebook).to be_an_instance_of Notebook 
        end
        expect(assigns["notebooks"].size).to eq 5
      end

      it "sets @notes to the user's notes" do
        login_as(create(:user))
        create_x_many_objects 5, "note"
        User.any_instance.stub(:get_all_notebooks)
        User.any_instance.stub(:get_notes_from_evernote)
        get :index
        assigns["notes"].each do |note|
          expect(note.class).to eq Note 
        end
        expect(assigns["notes"].size).to eq 5
      end
    end

    describe "GET notes/sync/initial/ --> notes#initial_sync"  do
      it "if current user synced, then it does nothing" 
      # do
        # user = create(:user)
        # create_x_many_objects(10, "note")
        # user.update(synced: true)
        # xhr :get, :initial_sync
      # end
      it "if current user not synced, then it returns" do
        user = create(:user)
        create_x_many_objects(10, "note")
          
        User.any_instance.stub(:count_all_notes).and_return(10)
        User.any_instance.stub(:get_all_notebooks)
        User.any_instance.stub(:get_last_usn)
        User.any_instance.stub(:add_notes_to_db)
        # Evernote::EDAM::NoteStore.any_instance.stub(:findNotes)

        user.update(synced: false)
        xhr :get, :initial_sync

        # count_all_notes is called -->mock this?
        # get_all_notebooks  --> mock this?

        # Note.where  --> we can mock this...

        # assigns["notes"]

        # calls getlast_usn on notestore..
        # updates current user synced.
        # renders json @notes
      end

      it "if current user has no evernote data..."

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

    describe "GET notes/sync/content -> notes#sync_all_notes_content"  do
      it "redirects to new_session_path" do
        get :sync_all_notes_content
        expect(response).to redirect_to new_session_path
      end
    end
  end


      #**************************INSTANCE METHODS ******************************************#

    describe "#handleUpdate" do 

    end
    describe "#get_filtered_sync_chunk note_store" do 

    end
    describe 'get_last_usn(note_store)' do 
    end
    describe "count_all_notes" do 
    end
    describe "count_all_notebooks" do
    end
    describe "get_notes_from_evernote" do
    end
    describe "add_notes_to_db(notes)" do
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
             #  notes_sync_content GET    /notes/sync/content(.:format)               notes#sync_all_notes_content



end


# def index
#     if @notes.length < 1 && current_user.evernote_auth
#       get_all_notebooks
#       get_notes_from_evernote
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
