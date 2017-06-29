class User < ApplicationRecord
  has_many :participants
  has_many :events
  has_many :locations
end
