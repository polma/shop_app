class Product < ActiveRecord::Base
  attr_accessible :name, :description, :price
  belongs_to :category
end
