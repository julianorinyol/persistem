require 'csv'


# Load Thrift & Evernote Ruby libraries
require "evernote_oauth"

 class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  protected
  
  def restrict_access
    if !current_user || !current_user.evernote_auth
      # flash[:alert] = "You must log in."
      redirect_to new_session_path
    end
  end

  def set_my_notes_and_notebooks
    if current_user
      @notes = Note.where(user_id: current_user.id)
      @notebooks = Notebook.where(user_id: current_user.id)
    end
  end

  def set_note_store
    token = session[:authtoken]
    client = EvernoteOAuth::Client.new(token: token)
    @note_store = client.note_store
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

end