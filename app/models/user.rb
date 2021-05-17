class User < ApplicationRecord
  has_many :events, foreign_key: "administrator_id"
  has_many :attendances, foreign_key: "attendee_id"
end
