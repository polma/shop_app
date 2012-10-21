class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :get_buyer, :get_cart, :get_cart_sum

  private 

  def get_buyer
    if session[:buyer_id].nil?
      @current_buyer = Buyer.create
      session[:buyer_id] = @current_buyer.id
    end
    begin
      @current_buyer = Buyer.find(session[:buyer_id])
    rescue ActiveRecord::RecordNotFound
      @current_buyer = Buyer.create
    end
    @current_buyer
  end

  def get_cart
    @buyer = get_buyer
    @cart = Order.where("buyer_id = ? AND confirmed = false", @buyer.id).first
  end

  def get_cart_sum
    @cart = get_cart
    if @cart.nil? then return 0 end
    @cart.order_items.sum("price") / 100.0
  end
end
