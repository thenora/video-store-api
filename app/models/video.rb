class Video < ApplicationRecord
  has_many :rentals
  has_many :customers, :through => :rentals

  validates :title, presence: true

end
