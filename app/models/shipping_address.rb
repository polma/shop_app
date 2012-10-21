class ShippingAddress < ActiveRecord::Base
  attr_accessible :name, :surname, :city, :street, :house_nr, :flat_nr, :postal_code, :country, :order_id

  has_many :orders
end
