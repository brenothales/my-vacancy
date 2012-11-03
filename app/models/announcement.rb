class Announcement < ActiveRecord::Base
  belongs_to :city
  belongs_to :user
  belongs_to :category
  attr_accessible :content, :name, :value, :city_id, :tags, :category_id
  #acts_as_taggable_on :tags
  
  with_options :presence => true do |v| #já sabe que tem que ser :presence => true
    v.validates :name, :uniqueness => true
    v.validates :content
    v.validates :city_id
    v.validates :value, :numericality => { :greater_than => 0.0 }
    v.validates :category_id
    #v.validates :tags
  end
  
  def formated_created_at
    created_at.strftime("%d/%m/%Y")  
  end


end
