class Participant < ApplicationRecord
  belongs_to :user
  has_many :events, through: :event_participants
  has_many :event_participants
  has_many :locations, through: :events
end
