class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :attachment
      t.integer :deal_id

      t.timestamps
    end
  end
end
