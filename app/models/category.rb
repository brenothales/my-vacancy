class Category < ActiveRecord::Base
  has_many :announcements
  attr_accessible :name, :situation
  validates  :name, :presence => true, :uniqueness => true, :length => { :in => 3..100 }
end
