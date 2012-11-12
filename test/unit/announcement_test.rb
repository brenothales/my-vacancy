require 'test_helper'

class AnnouncementTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  fixtures :announcements, :users  

  def setup
    @user = users(:one)  
  end

  def test_should_respond_scopes
    [:for_rent, :for_sale, :for_buy, :actived?, :by_category, :announcements_by_user, :search].each do |scope_method|
      assert_respond_to Announcement, scope_method, "should respond to a scope_method : #{scope_method}"    
    end
  end

  def test_should_respond_to_formated_created_at
    assert_respond_to Announcement.new, :formated_created_at, "should respond to a formated created at"  
  end

end
