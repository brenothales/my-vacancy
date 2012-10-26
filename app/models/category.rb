class Category < ActiveRecord::Base
  attr_accessible :name, :situation
  validates  :name, :presence => true, :uniqueness => true
end
