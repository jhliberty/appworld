class ChargesController < ApplicationController
  before_filter :not_authenticated
  
  def new
    @charge = Charge.new
  end
  
  def create
    @user = current_user
    @charge = @user.charges.build(params[:charge])
    if @charge.save
      flash[:success] = "Yes!"
      redirect_to up_app_path(@charge.id)
    end
  end
end
