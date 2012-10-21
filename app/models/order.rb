class Order < ActiveRecord::Base
  attr_accessible :buyer_id, :sent, :confirmed
  has_many :order_items
  
  belongs_to :buyer
end
