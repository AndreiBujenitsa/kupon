class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.string :title
      t.text :description
      t.datetime :start_at
      t.datetime :end_at
      t.integer :discount

      t.timestamps
    end
  end
end
