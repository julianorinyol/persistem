require 'csv'


# Load Thrift & Evernote Ruby libraries
require "evernote_oauth"

 class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  protected
  
  def restrict_access
    if !current_user
      flash[:alert] = "You must log in."
      redirect_to new_session_path
    end
  end

  def set_my_notes
      if current_user
        @my_notes = Note.where(user_id: current_user.id)

      if @my_notes.length < 4 && current_user.evernote_auth
        getAllNotebooksForUser
        getNotesFromEvernote
      end
      @my_notes = Note.where(user_id: current_user.id)
      @my_notebooks = Notebook.where(user_id: current_user.id)
    end
  end

  def set_my_notebooks

  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

end