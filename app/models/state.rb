class State < ActiveRecord::Base
  attr_accessible :name, :uf
  has_many :cities
  validates :name, :presence => true
end
