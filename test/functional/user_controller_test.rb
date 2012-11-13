require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  setup do
    @user = users(:user_one)
    sign_in @user
    @controller = Admin::UsersController.new
    @request = ActionController::TestRequest.new 
    @response = ActionController::TestResponse.new 
  end

  test 'should respond to index' do
    get :index
    assert_response :success  
  end

end
