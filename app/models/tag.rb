class Tag < ActiveRecord::Base
  has_and_belongs_to_many :announcements
  attr_accessible :count, :name
  validates :name, :presence => true, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0 }
end
