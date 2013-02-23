class CreateConditions < ActiveRecord::Migration
  def change
    create_table :conditions do |t|
      t.text :description
      t.string :type
      t.integer :deal_id

      t.timestamps
    end
  end
end
