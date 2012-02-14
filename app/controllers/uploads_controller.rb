class UploadsController < ApplicationController
  before_filter :not_authenticated
  
  def new
    if params[:charge_id]
      @user = current_user
      @charge = Charge.where(:user_id => @user.id).last
      @upload = @charge.build_upload
      @upload.charge_id = params[:charge_id]
    end
  end
  
  def create
  	if AWS::S3::S3Object.store(
  	    sanitize_filename(params[:upload][:file].original_filename),
  	    params[:upload][:file].read,
  	    BUCKET,
  	    :access => :authenticated_read, 
  	    :content_disposition => "attachment; filename=#{params[:upload][:file].original_filename}", 
  	    :content_type => "application/octet-stream", 
  	    :cache_control => "Cache-Control: must-revalidate, post-check=0, pre-check=0"
	    )    
	    @user = current_user
      @charge = Charge.where(:user_id => @user.id).last
      @upload = @charge.build_upload(:original_filename => params[:upload][:file].original_filename.to_s)
  	  if @upload.save
  	    flash[:success] = "Success, please enter info about your upload."
  	    redirect_to edit_upload_path(@upload)
	    else
	      redirect_to new_upload_path
      end
    else
    	render new_upload_path, :notice => "Couldn't complete the upload'"
  	end
  end
  
  def edit
    @upload = Upload.find(params[:id])
  end
  
  def update
    @upload = Upload.find(params[:id])
    if @upload.update_attributes(params[:upload])
      flash[:success] = "Yes"
      redirect_to edit_upload_path(@upload)
    else
      flash[:failure].now = "No"
      render edit_upload_path(@upload)
    end
  end
  
  def destroy
    if (params[:id])
      @upload = Upload.find(params[:id])
  		if AWS::S3::S3Object.find(@upload.original_filename, BUCKET).delete
  		  @upload.destroy
  		end
  		redirect_to dashboard_path, :success => "Destroyed!"
  	else
  		render :text => "No object was found to delete!"
  	end
  end
  
  private
  def sanitize_filename(file_name)
  	just_filename = File.basename(file_name)
 		just_filename.sub(/[^\w\.\-]/,'_')
	end
end
