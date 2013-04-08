class Condition < ActiveRecord::Base
  attr_accessible :deal_id, :description, :type
  belongs_to :deal
  set_inheritance_column :condition_type
end