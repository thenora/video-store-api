class ChangeRentals < ActiveRecord::Migration[6.0]
  def change
    rename_index :rentals, 'videos_id', 'video_id'

    change_table :rentals do |t|
      t.rename :videos, :video   # t.string -> t.rename
    end
  end
end
