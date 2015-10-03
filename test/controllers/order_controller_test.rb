require 'test_helper'

class OrderControllerTest < ActionController::TestCase
  test "should get order" do
    get :order
    assert_response :success
  end

  test "should get congratulations" do
    get :congratulations
    assert_response :success
  end

end
