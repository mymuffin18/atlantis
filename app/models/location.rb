class Location < ApplicationRecord
  belongs_to :user

  validates :longitude, presence: true
  validates :latitude, presence: true
  validates :locname, presence: true

  def as_json(_options = {})
    super(include: :user)
  end
end
