class Announcement < ActiveRecord::Base
  belongs_to :city
  belongs_to :user
  belongs_to :category
  attr_accessible :content, :name, :value, :city_id, :tag_list, :category_id
  acts_as_taggable
 
  with_options :presence => true do |v| #já sabe que tem que ser :presence => true
    v.validates :name, :uniqueness => true
    v.validates :content
    v.validates :city_id
    v.validates :value, :numericality => { :greater_than => 0.0 }
    v.validates :category_id
    v.validates :tag_list
  end
  
  default_scope order('id DESC')

  scope :actived?, where(:situation => true)
  scope :for_rent, where(:category_id => 1)
  scope :for_buy, where(:category_id => 1)
  scope :for_sale, where(:category_id => 1)
  scope :announcements_by_user, lambda { |user| where(:user_id => user.id) }
  
  def formated_created_at
    created_at.strftime("%d/%m/%Y")  
  end

  def self.search(search)
    unless search.nil? || search.empty?
      where('name LIKE ?',"%#{search}%").order("#{$order_by} #{$ordem}")
    else
      order("#{$order_by} #{$ordem}")
    end
  end

end
