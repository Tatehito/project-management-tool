class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?
  
  private

  def current_user
    Member.find(session[:user_id])
  end

  def logged_in?
    !session[:user_id].nil?
  end
end
