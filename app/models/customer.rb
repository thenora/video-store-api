class Customer < ApplicationRecord
  has_many :rentals
  has_many :videos, through: :rentals

  # TODO Do we need to test models?
  def take_movie_home
    self.videos_checked_out_count += 1
		self.save
  end

  def update_checkout(count)
    self.videos_checked_out_count += count
    self.save
  end


end
