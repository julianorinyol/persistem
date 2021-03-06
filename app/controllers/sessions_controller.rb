 class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      session[:authtoken] = current_user.evernote_auth
      session[:dry_run] = true
      redirect_to notes_path
    elsif current_user
      redirect_to notes_path    
    else
      render :new
    end
    
  end

  def destroy
    session[:user_id] = nil
    session[:authtoken] = nil
    redirect_to notes_path
  end
end