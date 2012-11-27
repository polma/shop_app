require 'test_helper'

class OrderControllerTest < ActionController::TestCase
  test 'can confirm order' do
    Order.create(:buyer_id => 1, :confirmed => false)
    Order.create(:buyer_id => 2, :confirmed => false)
    Order.create(:buyer_id => 3, :confirmed => false)
    Order.create(:buyer_id => 4, :confirmed => false)
    post :confirm_json, {:format => :json}, {:buyer_id => 1}
    assert_match(/Confirmed/, @response.body)
  end
end
