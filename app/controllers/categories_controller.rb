class CategoriesController < ApplicationController
  def show
    @categories = Category.all
    @category = Category.find(params[:id])
    @products = Product.where('category_id = ?', params[:id]) #there surely is a better way to write this
  end
end
