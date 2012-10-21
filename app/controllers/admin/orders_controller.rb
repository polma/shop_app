class Admin::OrdersController < Admin::AdminController
  def index
    @categories = Category.all
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end
end
