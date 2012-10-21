class ApplicationController < ActionController::Base
  protect_from_forgery
  def get_buyer
    return @current_buyer if not @current_buyer.nil?
    @current_buyer = Buyer.create
    @current_buyer
  end
end
