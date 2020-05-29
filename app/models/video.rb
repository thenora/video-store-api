class Video < ApplicationRecord
  has_many :rentals
  has_many :customers, :through => :rentals

  validates :title, presence: true
  validates :overview, presence: true
  validates :release_date, presence: true
  validates :total_inventory, presence: true
  validates :available_inventory, presence: true

  def send_movie_out
    self.available_inventory -= 1
		self.save
  end

  def update_inventory(count)
    self.available_inventory += count
    self.save
  end

end
