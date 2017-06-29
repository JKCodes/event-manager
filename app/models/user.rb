class User < ApplicationRecord
  has_many :participants
  has_many :events
  has_many :locations

  has_secure_password

  validates :username, presence: true
  validates :username, uniqueness: true
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :password, presence: true
  validates :password, length: { minimum: 8 }
end
