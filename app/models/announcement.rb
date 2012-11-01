class Announcement < ActiveRecord::Base
  belongs_to :city
  belongs_to :user
  belongs_to :category
  has_and_belongs_to_many :tags
  attr_accessible :content, :name, :value
  
  with_options :presence => true do |v| #já sabe que tem que ser :presence => true
    v.validates :name, :uniqueness => true
    v.validates :content
    v.validates :city_id
    v.validates :value, :numericality => { :greater_than => 0.0 }
    v.validates :category_id
  end

end
