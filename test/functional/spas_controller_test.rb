require 'test_helper'

class SpasControllerTest < ActionController::TestCase
  test 'can get categories' do
    post :get_categories, :format => :json
    assert_match(/kat1/, @response.body)
  end
  test 'can get products' do
    post :get_products, :format => :json
    assert_match(/p1/, @response.body)
  end
end
