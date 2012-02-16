class AddColumnsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :admin, :boolean, :default => false
    add_column :users, :first_name, :string, :default => ""
    add_column :users, :last_name, :string, :default => ""
  end

  def self.down
    remove_column :users, :admin
    remove_column :users, :first_name
    remove_column :users, :last_name
  end
end
