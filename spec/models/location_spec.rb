require 'rails_helper'

RSpec.describe Location, type: :model do
  let!(:location) { described_class.new }
  let(:user) { User.create(name: 'user_name') }

  it 'has a user_id' do
    location.user_id = nil
    location.longitude = 0
    location.latitude = 0
    location.locname = 'location_name'

    expect(location).not_to be_valid
  end

  it 'has a latitude' do
    location.user_id = 1
    location.longitude = 0
    location.latitude = nil
    location.locname = 'location_name'

    expect(location).not_to be_valid
  end

  it 'has a longitude' do
    location.user_id = 1
    location.longitude = nil
    location.latitude = 0
    location.locname = 'location_name'

    expect(location).not_to be_valid
  end

  it 'has a location name' do
    location.user_id = 1
    location.longitude = 0
    location.latitude = 0
    location.locname = nil

    expect(location).not_to be_valid
  end

end
