class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.text :condition
      t.float :amount
      t.integer :deal_id

      t.timestamps
    end
  end
end
