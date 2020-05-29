class ChangeRentals < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :rentals, column: :videos_id
  end
end
