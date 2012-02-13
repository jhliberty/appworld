class UploadsController < ApplicationController
  
  def new
    @upload = Upload.new
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
  	  @upload = Upload.new(:filename => params[:upload][:file].original_filename.to_s)
  	  @upload.save
  	  flash[:success] = "Yay!"
  	  redirect_to dashboard_path
    else
    	render new_upload_path, :notice => "Couldn't complete the upload'"
  	end
  end
  
  def edit
    @upload = Upload.find(params[:id])
  end
  
  def destroy
    if (params[:object])
  		AWS::S3::S3Object.find(params[:object], BUCKET).delete
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
