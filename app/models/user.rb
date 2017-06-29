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

  def self.find_or_create_by_omniauth(auth)
    where(email: auth["info"]["email"]).first_or_create do |user|
      user.username = SecureRandom.hex
      user.password = SecureRandom.uuid
    end
  end
end
