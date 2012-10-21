class CartController < ApplicationController
  def index
    @categories = Category.all
    @cart = get_cart
    if @cart.nil? then return end
    @products = []
    @cart.order_items.each do |t|
      @products << t.product
    end
  end

  def show
      
  end

  def add
    @buyer = get_buyer

    #get cart for the buyer, we allow each buyer
    #to have one cart (unconfirmed order)
    #in addition to that, he may have several
    #confirmed orders

    @cart = get_cart

    if @cart.nil?
      @cart = Order.create({:buyer_id => @buyer.id, :confirmed => false, :sent => false})
    end
    
    #now add the item to the cart
    OrderItem.create({:order_id => @cart.id, :product_id => params[:id], :quantity => 1,
                      :price => Product.find(params[:id]).price})

    #TODO: add checks for product (params[:id] could be modified)
    
    redirect_to root_url, :notice => "Dodano produkt do koszyka."

  end
end
