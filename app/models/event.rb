class Event < ApplicationRecord
  belongs_to :user
  belongs_to :location
  has_many :event_participants
  has_many :participants, through: :event_participants

  validates :name, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :valid_time?

  def location_attributes=(attributes)
    self.location = Location.by_user(self.user).find_or_create_by(name: attributes[:name]) if attributes[:name] != ""
  end

  def participants_attributes=(attributes)
    attributes.values.each do |attributes|
      self.participants << Participant.by_user(self.user).find_or_create_by(nickname: attributes[:nickname]) if attributes[:nickname] != ""
    end
  end

  # class scope methods
  def self.by_user(user_id)
    where(user: user_id)
  end

  def self.old_events
    where("start_time < ?", DateTime.now)
  end

  def self.starts_today
    self.starts_now_til_days(0)
  end

  def self.starts_now_til_days(days)
    where("start_time >= ? AND start_time <= ?", DateTime.now.beginning_of_day, (DateTime.now + days).end_of_day)
  end

  def self.upcoming_events
    where("start_time >= ?", DateTime.now)
  end

  def self.happening_now
    where("start_time <= ? AND end_time >= ?", DateTime.now, DateTime.now)
  end

  # validation code below
  def valid_time?
    return if !self.user || !self.location || !self.start_time || !self.end_time

    errors.add(:start_time, "can't be between another event's start and end time at the same location") if intersects_another_event?(self.start_time)
    errors.add(:end_time, "can't be between another event's start and end time at the same location") if intersects_another_event?(self.end_time)
    errors.add(:end_time, "can't be before the start time") if end_time < start_time
    errors.add(:start_time, "can't be before today") if start_time < Time.zone.today.beginning_of_day.to_datetime
  end

  private

    def intersects_another_event?(time)
      self.user.events.any? do |event|
        if self.location == event.location && event != self
          if event.start_time < time && time < event.end_time
            true
          end
        end
      end
    end
end
