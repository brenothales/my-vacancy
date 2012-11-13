class Comment < ActiveRecord::Base
  belongs_to :announcement
  attr_accessible :name, :content, :email

  scope :by_situation, lambda { |situation| where(:situation => situation) }
  
  scope :has_new_comments, lambda { |user| 
    joins(:announcement).where('comments.situation = ? AND announcements.user_id = ?', false, user.id).group('comments.announcement_id')
  }

  scope :by_announcement_by_user, lambda { |user|
    joins(:announcement).where('announcements.user_id = ?', user.id).order('created_at')  
  }
  
  #postgres : scope :has_new_comments, where(:situation => false).group('comments.id, comments.announcement_id')
  scope :unread, lambda { |user|
    if user.is_role? :administrador
      where(:situation => false).order('id DESC')
    else
      joins(:announcement).where('comments.situation = ? AND announcements.user_id = ?', false, user.id) 
    end
  }

  scope :read, lambda { |user|
    if user.is_role? :administrador
      where(:situation => true).order('id DESC')
    else
      joins(:announcement).where('comments.situation = ? AND announcements.user_id = ?', true, user.id) 
    end
  }

  with_options :presence => true do |validation|
    validation.validates :name
    validation.validates :email, :format => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
    validation.validates :content, :length => { :maximum => 250 }
    validation.validates :announcement_id  
  end

  def formated_created_at
    created_at.strftime("%d/%m/%Y")  
  end

  def self.search(search, order_by, ordem)
    unless search.nil? || search.empty?
      joins(:announcement).where('comments.name LIKE :search OR announcements.name = :search', :search => "%#{search}%").order("#{order_by} #{ordem}")
    else
      order("#{order_by} #{ordem}")
    end
  end
 
end
