class ProductsController < ApplicationController
  def show
    @categories = Category.all
    @product = Product.find(params[:id])
  end
end
