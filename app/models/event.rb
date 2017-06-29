require 'pry'
class Event < ApplicationRecord
  belongs_to :user
  belongs_to :location
  has_many :event_participants
  has_many :participants, through: :event_participants

  validates :name, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :valid_time?

  def valid_time?
    return if !self.user || !self.location || !self.start_time || !self.end_time

    errors.add(:start_time, "can't be between another event's start and end time at the same location") if intersects_another_event?(self.start_time)
    errors.add(:end_time, "can't be between another event's start and end time at the same location") if intersects_another_event?(self.end_time)
    errors.add(:end_time, "can't be before the start time") if end_time < start_time
    errors.add(:start_time, "can't be before current time") if start_time < DateTime.now
  end

  private
    def intersects_another_event?(time)
      self.user.events.any? do |event|
        if self.location == event.location
          if event.start_time < time && time < event.end_time
            true
          end
        end
      end
    end
end
