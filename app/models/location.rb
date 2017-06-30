class Location < ApplicationRecord
  belongs_to :user
  has_many :events
  has_many :participants, through: :events

  validates :name, presence: true

  # class scope methods
  def self.by_user(user_id)
    where(user: user_id)
  end
end
