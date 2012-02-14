class Charge < ActiveRecord::Base
  has_one :upload
  belongs_to :user
  
  attr_accessible :stripe_card_token

end
