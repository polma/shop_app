class Admin::OrdersController < Admin::AdminController
  def index
    @categories = Category.all
    #@orders = Order.all
  end
end
