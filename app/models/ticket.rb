class Ticket < ActiveRecord::Base
  attr_accessible :code, :deal_id, :user_id
end
