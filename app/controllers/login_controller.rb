class LoginController < ApplicationController
  rescue_from OAuth::Unauthorized, :with => Proc.new{redirect_to root_path}

  def callback
    session[:authtoken] = request.env['omniauth.auth']['credentials']['token']
    session[:dry_run] = true
    current_user.evernote_auth = request.env['omniauth.auth']['credentials']['token']
    current_user.save
    redirect_to root_path
  end

  def oauth_failure
    redirect_to root_path
  end

  def logout
    session.clear
    redirect_to root_path
  end

end