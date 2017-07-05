class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.by_user(user_id)
    where(user: user_id)
  end
end
