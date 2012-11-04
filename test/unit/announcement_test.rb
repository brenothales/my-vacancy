require 'test_helper'

class AnnouncementTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
   def test_should_respond_to_method_search
    assert_respond_to Announcement, :search, 'should respond to method -search-' 
  end

end
