class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.string :filename
      t.integer :downloads
      t.integer :charge_id
      t.string :original_filename
      t.text :description
      

      t.timestamps
    end
  end
end
