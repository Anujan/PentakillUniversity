require 'test_helper'

class UserControllerTest < ActionController::TestCase
  test "should get verify" do
    get :verify
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get requests" do
    get :requests
    assert_response :success
  end

end
