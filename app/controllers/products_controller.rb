class ProductsController < ApplicationController
  def show
    @categories = Category.all
    @product = Product.find(params[:id])
  end
  def create
    render :text => @c.name
  end
end
