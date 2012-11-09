require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  setup do
    @user = users(:one)
    @controller = Admin::UsersController.new
    @request = ActionController::TestRequest.new 
    @response = ActionController::TestResponse.new 
  end

  test 'should respond to index' do
    get :index
    assert_response :success  
  end

end
