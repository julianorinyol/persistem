  class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  before_filter :restrict_access
  before_action :set_my_notes_and_notebooks, only: [:index, :show, :initial_sync]
  before_action :set_note_store, only: [:show ]

  # GET /notes
  # GET /notes.json
  def index
    if @notes.length < 1 && current_user.evernote_auth
      current_user.get_all_notebooks
      current_user.get_notes_from_evernote 10
      # reset @notes and @notebooks after the query, in case of change..
      @notes = current_user.notes
      @notebooks = current_user.notebooks
      current_user.create_sample_data if @notebooks.size < 1 || @notes.size < 5 
    end

    @note = Note.new
    @question = Question.new
    @synced = current_user.synced

    respond_to do |format|
      format.html
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"your-notes\" "
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
    if !@note.content
      @note.get_content(@note_store, @note)
    end

    @question = Question.new
    @questions = Question.where(note_id: params[:id].to_i, user_id: current_user.id )
    @synced = current_user.synced
    @answer = Answer.new
  end

  def sync 
    current_user.sync
  end

  def initial_sync
    if !current_user.synced
      @notes = current_user.initial_sync
      render json: @notes
    end
  end

  def sync_all_notes_content
    notes = current_user.sync_all_notes_content
    render json: notes 
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_note
        @note = Note.find(params[:id])
        rescue ActiveRecord::RecordNotFound
        redirect_to notes_path
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_params
      params[:note]
      params.require(:note).permit(:content, :public, :title)
    end
end
