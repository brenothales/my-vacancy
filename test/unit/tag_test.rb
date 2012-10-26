require 'test_helper'

class TagTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  setup do
    @tag = tags(:one)
  end

  test 'should have a name' do
    tag = Tag.new(:name => nil)
    assert !tag.save, 'should have a name'
  end

  test 'should be uniq' do 
    assert_difference('Tag.count') do 
      post :create, tag: { name: @tag.name, count: @tag.count }    
    end
  end

end


