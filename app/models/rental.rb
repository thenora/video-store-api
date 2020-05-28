class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :video

  def checkedin?
    return checkin_date.nil?
  end

  def checkin(date)
    checkin_date = date
    self.save
  end
end
