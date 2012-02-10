class Upload < ActiveRecord::Base
  belongs_to :charge
  
  attr_accessor :file
  
  
end
