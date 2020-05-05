class ApplicationController < ActionController::Base
  
  include SessionsHelper
  
  private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def limit_action
    unless current_user.task
      redirect_to root_url
    end
  end
end
