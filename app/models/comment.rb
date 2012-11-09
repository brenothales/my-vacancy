class Comment < ActiveRecord::Base
  belongs_to :announcement

  scope :has_new_comments, lambda { |user| 
    joins(:announcement).where('comments.situation = ? AND announcements.user_id = ?', false, user.id).group('comments.announcement_id')
  }
  
  #postgres : scope :has_new_comments, where(:situation => false).group('comments.id, comments.announcement_id')
  scope :unread, lambda { |user|
    joins(:announcement).where('comments.situation = ? AND announcements.user_id = ?', false, user.id) 
  }
  scope :read, lambda { |user|
    joins(:announcement).where('comments.situation = ? AND announcements.user_id = ?', true, user.id) 
  }


  with_options :presence => true do |validation|
    validation.validates :name
    validation.validates :email, :format => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
    validation.validates :content
    validation.validates :announcement_id  
  end

  def formated_created_at
    created_at.strftime("%d/%m/%Y")  
  end

  def self.search(search, order_by, ordem)
    unless search.nil? || search.empty?
      where('name LIKE ?',"%#{search}%").order("#{order_by} #{ordem}")
    else
      order("#{order_by} #{ordem}")
    end
  end
 
end
