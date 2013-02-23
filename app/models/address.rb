class Address < ActiveRecord::Base
  attr_accessible :address, :city, :country, :deal_id, :integer, :phone, :province, :site, :zip
end
