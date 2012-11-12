require 'test/unit'

class CommentTest < Test::Unit::TestCase
  
  def test_should_respond_class_methods
    [:has_new_comments, :unread, :read, :search].each do |scope_method| 
      assert_respond_to Comment, scope_method, "should respond to a scope_method : #{scope_method}"    
    end  
  end

  def test_should_respond_to_formated_created_at
    assert_respond_to Comment.new, :formated_created_at  
  end

  def test_comment_content_should_have_characters
    comment = Comment.new(:content => 'a' * 250)
    assert !comment.save, "should not have more than 250 char"  
  end

  def test_email_should_have_this_format
    comment = Comment.new(:email => 'lccezinha@gmail.com')
    assert_match /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, comment.email, 'shoudl have this format : lccezinha@gmail.com'   
  end


end
