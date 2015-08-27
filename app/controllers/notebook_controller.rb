class NotebookController < ApplicationController
  before_filter :restrict_access

  def list_all
    @notebooks = Notebook.where(user_id: current_user.id)
      render json: @notebooks
  end
end