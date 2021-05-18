class User < ApplicationRecord
  has_many :events, foreign_key: "administrator_id"
  has_many :attendances, foreign_key: "attendee_id"

  after_create :welcome_send

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end
end
