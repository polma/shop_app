class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :get_buyer

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
end
