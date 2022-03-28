require 'rails_helper'

RSpec.describe Disaster, type: :model do
  let!(:disaster) { described_class.new }

  it 'has a disaster_type' do
    disaster.disaster_type = nil
    disaster.avatar.attach(io: File.open('app/assets/images/default-profile.jpg'), filename: 'default-profile.jpg', content_type: 'image/jpg')

    expect(disaster).not_to be_valid
  end 

  it 'has a url attached' do
    disaster.disaster_type = 'disaster_type'
    disaster.avatar = nil

    expect(disaster).not_to be_valid
  end 
end
