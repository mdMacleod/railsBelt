class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protect_from_forgery with: :exception
  before_action :authorized
  helper_method :current_user
  helper_method :logged_in?
  

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !current_user.nil?
  end

  def authorized
    flash[:error] = "You must be logged in to view this site"
    redirect_to '/login' unless logged_in?
  end
end
