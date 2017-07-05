class Location < ApplicationRecord
  belongs_to :user
  has_many :events, dependent: :destroy  
  has_many :participants, through: :events

  validates :name, presence: true
end
