require 'test_helper'

class RequestControllerTest < ActionController::TestCase
  test "should get accept" do
    get :accept
    assert_response :success
  end

  test "should get decline" do
    get :decline
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

end
