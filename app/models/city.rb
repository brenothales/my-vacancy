class City < ActiveRecord::Base
  attr_accessible :name, :state_id
  has_many :announcements
  belongs_to :state
  validates :name, :presence => true
  validates :state_id, :presence => true
end
