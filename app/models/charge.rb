class Charge < ActiveRecord::Base
  has_one :upload
  belongs_to :user
end
