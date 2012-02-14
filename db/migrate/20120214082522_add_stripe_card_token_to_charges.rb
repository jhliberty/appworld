class AddStripeCardTokenToCharges < ActiveRecord::Migration
  def change
    add_column :charges, :stripe_card_token, :string
  end
end
