class Attendance < ApplicationRecord
  belongs_to :event
  belongs_to :attendee, class_name: "User"

  after_create :new_attendee_email_send

  def new_attendee_email_send
    UserMailer.new_attendee_email(self).deliver_now
  end
end