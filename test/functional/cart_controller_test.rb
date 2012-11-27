require 'test_helper'

class CartControllerTest < ActionController::TestCase
  test 'can add to the cart' do
    assert_difference('OrderItem.count') do
      post :add, {:id => 1}
    end
  end
  test 'can get cart contents' do
    post :add, {:id => 1}
    post :get, :format => :json
    assert_match(/p1/, @response.body)
  end
end
