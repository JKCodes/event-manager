class Event < ApplicationRecord
  belongs_to :user
  belongs_to :location
  has_many :participant, through: :event_participants
  has_many :event_participants
end
