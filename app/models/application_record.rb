class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.by_user(user_id)
    where(user: user_id)
  end

  def self.previous(object)
    objects = self.by_user(object.user)
    new_index = objects.index(object) - 1
    new_index < 0 ? objects.last : objects[new_index]
  end

  def self.next(object)
    objects = self.by_user(object.user)
    new_index = objects.index(object) + 1
    new_index == objects.size ? objects.first : objects[new_index]
  end

  def self.indexes(object)
    objects = self.by_user(object.user)
    objects.map { |e| e.id }
  end
end
