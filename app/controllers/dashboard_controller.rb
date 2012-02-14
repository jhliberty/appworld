class DashboardController < ApplicationController
  
  def index
    @user = current_user
    @uploads = @user.uploads
    @objects = AWS::S3::Bucket.find(BUCKET).objects
    @bucket = BUCKET
  end
end
