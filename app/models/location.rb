class Location < ApplicationRecord
  belongs_to :user
  has_many :events, dependent: :destroy  
  has_many :participants, through: :events

  validates :name, presence: true

  def self.previous(location)
    locations = self.by_user(location.user)
    new_index = locations.index(location) - 1
    new_index < 0 ? locations.last : locations[new_index]
  end

  def self.next(location)
    locations = self.by_user(location.user)
    new_index = locations.index(location) + 1
    new_index == locations.size ? locations.first : locations[new_index]
  end
end
