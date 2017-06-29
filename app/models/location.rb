class Location < ApplicationRecord
  belongs_to :user
  has_many :events
  has_many :participants, through: :events
end
