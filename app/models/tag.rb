class Tag < ActiveRecord::Base
  attr_accessible :count, :name
  validates :name, :presence => true, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0 }
end
