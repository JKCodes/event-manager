class Participant < ApplicationRecord
  belongs_to :user
  has_many :event_participants
  has_many :events, through: :event_participants
  has_many :locations, through: :events

  validates :nickname, presence: true

  def self.by_user(user_id)
    where(user: user_id)
  end

end
