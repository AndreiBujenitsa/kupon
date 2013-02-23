class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :code
      t.integer :deal_id
      t.integer :user_id

      t.timestamps
    end
  end
end
