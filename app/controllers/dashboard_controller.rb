class DashboardController < ApplicationController
  before_filter :not_authenticated
  
  def index
    @user = current_user
    @uploads = @user.uploads
  end
end
