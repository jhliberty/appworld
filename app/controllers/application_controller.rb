class ApplicationController < ActionController::Base
  protect_from_forgery
  
  # before_filter :require_login, :except => [:not_authenticated]
  
  protected
  
  def not_authenticated
    unless current_user
     redirect_to signin_path, :alert => "Please login first."
   end
  end
  
  BUCKET = 'appwerld'
end
