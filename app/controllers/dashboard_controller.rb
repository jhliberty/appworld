class DashboardController < ApplicationController
  
  def index
    @objects = AWS::S3::Bucket.find(BUCKET).objects
    @bucket = BUCKET
    @url = AWS::S3::S3Object.url_for('breakfast.jpg', BUCKET, :expires_in => 1200)
  end
  
  def upload
  	begin
  		AWS::S3::S3Object.store(sanitize_filename(params[:file].original_filename), params[:file].read, BUCKET, :access => :public_read)
  		redirect_to dashboard_path
  	rescue
  		render :index, :notice => "Couldn't complete the upload'"
  	end 
  end
  
  def delete
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
