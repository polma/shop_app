class OrderItem < ActiveRecord::Base
  attr_accessible :price, :quantity, :product
  belongs_to :order
  belongs_to :product
end
