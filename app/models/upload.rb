class Upload < ActiveRecord::Base
  belongs_to :charge
  has_one :user, :through => :charge
  after_create :update_user
    
  attr_accessible :charge_id, :original_filename, :filename, :description
  
  private
  
  def update_user
    user = User.find(self.charge.user_id)
    card = self.charge.stripe_card_token
    customer = Stripe::Charge.create(
      :amount => 1000,
      :currency => "usd",
      :card => card,
      :description => self.user.email
    )
    user.update_attributes(:stripe_customer_token => customer.id)
    save!
  end
  
end
