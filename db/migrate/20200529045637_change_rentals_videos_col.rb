class ChangeRentalsVideosCol < ActiveRecord::Migration[6.0]
  def change
    remove_column(:rentals, :videos_id)
  end
end
