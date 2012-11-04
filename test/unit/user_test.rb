require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def test_should_respond_to_method_is_role
    assert_respond_to User.new, :is_role?, 'should respond to method -is_role-' 
  end

end
