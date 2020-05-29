class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :video

  def checkout_update(date)
    self.checkout_date = date
    self.due_date = date + 7
  end

  def checkedin?
    return checkin_date.nil?
  end

  def checkin_update(date)
    checkin_date = date
    self.save
  end
end
