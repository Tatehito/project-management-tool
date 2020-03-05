class ApplicationController < ActionController::Base
  helper_method :current_user
  
  private

  def current_user
    Member.find(session[:user_id])
  end
end
