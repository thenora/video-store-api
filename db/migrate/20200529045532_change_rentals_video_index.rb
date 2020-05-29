class ChangeRentalsVideoIndex < ActiveRecord::Migration[6.0]
  def change
    remove_index :rentals, :videos_id
  end
end
