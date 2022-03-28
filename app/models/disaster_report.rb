class DisasterReport < ApplicationRecord
  belongs_to :disaster
  belongs_to :user
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :disaster_level, presence: true
  validates :description, presence: true
  validates_datetime :date_occured

  has_many_attached :images
end
