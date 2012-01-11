class UsersController < ApplicationController
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      login(params[:username], params[:password])
      flash[:success] = "Welcome to App World!"
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def edit
    @user = current_user
  end
end
