class OrderController < ApplicationController
  def index
  end
  def confirm
    @cart = get_cart
    if @cart.nil?
        redirect_to root_url, :notice => "Nie potwierdzam pustego zamowienia."
    end
    @shipping = ShippingAddress.new
  end

  def validate_address

    @cart = get_cart
    if @cart.nil?
      redirect_to root_url, :notice => "Blad podczas potwierdzania zamowienia."
    end

    #no validation for now (will do it in model anyway)
    @cart.confirmed = true
    @cart.save
    address = params[:shipping_address]
    address[:order_id] = @cart.id
    ShippingAddress.create(address)

    redirect_to root_url, :notice => "Zamowienie zostalo potwierdzone!"
  end

  def confirm_json
    @cart = get_cart
    if @cart.nil? #shouldn't happen
      return
    end
    @cart.confirmed = true
    @cart.save
    address = ShippingAddress.new
    address.order_id = @cart.id
    address.save
    respond_to do |format|
      format.json {render :json => "Confirmed"}
    end
  end

end
