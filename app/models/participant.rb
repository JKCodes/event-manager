class Participant < ApplicationRecord
  belongs_to :user
  has_many :event_participants
  has_many :events, through: :event_participants
  has_many :locations, through: :events

  validates :nickname, presence: true
end
