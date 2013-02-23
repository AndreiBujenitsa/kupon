class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :country
      t.string :province
      t.string :city
      t.string :address
      t.integer :phone
      t.integer :zip
      t.string :site
      t.integer :deal_id

      t.timestamps
    end
  end
end
