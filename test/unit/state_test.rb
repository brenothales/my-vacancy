require 'test_helper'

class StateTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'should have a name' do
    state = State.new(:name => nil)
    assert !state.save, 'should have a name'
  end

end
