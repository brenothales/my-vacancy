require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.new
  end  
  
  def test_should_respond_to_method_is_role
    assert_respond_to @user, :is_role?, 'should respond to method -is_role-' 
  end

  def test_phone_should_have_correct_format
    @user.phone = '(45) 9999-9999'
    assert_match /\([0-9]{2}\)\s[0-9]{4}-[0-9]{4}/, @user.phone, 'should have format : (99) 9999-9999'
  end

end
