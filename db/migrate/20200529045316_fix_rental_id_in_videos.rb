class FixRentalIdInVideos < ActiveRecord::Migration[6.0]
  def change
    remove_reference :rentals, :videos, foreign_key: true
    add_reference :rentals, :video, foreign_key: true
  end
end
