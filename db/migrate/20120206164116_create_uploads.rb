class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.string :filename
      t.string :url
      t.integer :downloads
      t.integer :charge_id

      t.timestamps
    end
  end
end
