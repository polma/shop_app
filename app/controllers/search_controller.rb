class SearchController < ApplicationController
  def results
    @categories = Category.all
    @query = params[:q].clone #clone because we don't want to change what search form is showing
    if not params[:q][:price_lteq].empty?
      @query[:price_lteq] = @query[:price_lteq].to_i*100
    end
    if not params[:q][:price_gteq].empty?
      @query[:price_gteq] = @query[:price_gteq].to_i*100
    end
    @q = Product.search(@query)
    @result = @q.result
  end
end
