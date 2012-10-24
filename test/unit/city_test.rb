require 'test_helper'

class CityTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'should have a name' do
    city = City.new(:name => nil)
    assert !city.save, 'should have a name'
  end

  test 'should have a state' do 
    city = City.new(:state_id => nil)
    assert !city.save, 'should have a state_id'
  end

end
