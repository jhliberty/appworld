class UploadsController < ApplicationController
  
  def new
    @upload = Upload.new
  end
  
  def create
  	if AWS::S3::S3Object.store(sanitize_filename(params[:file].original_filename), params[:file].read, BUCKET, :access => :public_read)
  	  flash[:notice] = "Yay!"
  	  redirect_to new_upload_path
    else
  	render new_upload_path, :notice => "Couldn't complete the upload'"
  	end
  end
  
  def destroy
    if (params[:object])
  		AWS::S3::S3Object.find(params[:object], BUCKET).delete
  		redirect_to dashboard_path
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