class State < ActiveRecord::Base
  attr_accessible :name
  has_many :cities
  validates :name, :presence => true
end
