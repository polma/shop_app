class OrderItem < ActiveRecord::Base
  attr_accessible :price, :quantity, :product_id, :order_id
  belongs_to :order
  belongs_to :product
end
