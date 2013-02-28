class ApplicationController < ActionController::Base
  protect_from_forgery
  def authenticate_admin_user! #use predefined method name
      redirect_to '/' and return if user_signed_in? && !current_user.is_admin? 
      authenticate_user! 
    end 
  def current_admin_user #use predefined method name
    return nil if user_signed_in? && !current_user.is_admin? 
    current_user 
  end
end
