class Disaster < ApplicationRecord
  validates :disaster_type, presence: true
  has_one_attached :avatar
  validates :avatar, presence: true
end
