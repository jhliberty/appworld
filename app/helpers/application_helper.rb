module ApplicationHelper
    
  def download_url_for(upload)
    AWS::S3::S3Object.url_for(upload, "jhliberty")
  end
end
