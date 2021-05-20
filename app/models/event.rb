class Event < ApplicationRecord
  belongs_to :administrator, class_name: "User"
  has_many :attendances
  has_many :attendees, through: :attendances

  validates :start_date, presence: true
  validate :start_date_is_future

  validates :duration, presence: true
  validate :duration_is_multiple_of_5
  
  validates :title, presence: true, length: { in: 5..140 }
  validates :description, presence: true, length: { in: 20..1000 }
  validates :price, presence: true, inclusion: 1..1000
  validates :location, presence: true

  def start_date_is_future
    errors.add(:start_date, 'Date antérieure à la date du jour, action impossible') unless start_date && start_date > Time.now
  end

  def duration_is_multiple_of_5
     errors.add(:duration, 'La durée de votre évènement doit être un multiple de 5') unless duration && duration > 0 && duration % 5 == 0
  end

  def end_date
    self.start_date + duration
   end  

  def attendee?(user)
    self.attendees.include?(user)
  end

  def administrator?(user)
    user == administrator
  end
end
