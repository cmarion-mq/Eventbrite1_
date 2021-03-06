class Event < ApplicationRecord
  belongs_to :administrator, class_name: "User"
  has_many :attendances, through: :attendances
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
    errors.add(:start_date, 'Date antérieure à la date du jour, action impossible') unless start_date > Time.now
  end

  def duration_is_multiple_of_5
     errors.add(:duration, 'La durée de votre évenement doit être un multiple de 5') unless duration > 0 && duration % 5 == 0
  end
end
