class SessionsController < ApplicationController
  
  def new
    
  end
  
  def create
    if @user = login(params[:username], params[:password], params[:remember_me])
      flash[:success] = "You have signed into App World!"
      redirect_back_or_to root_path
    else
      render :new
    end
  end
  
  def destroy
    logout
    redirect_to(root_path, :notice => "Logged out!")
  end

end
