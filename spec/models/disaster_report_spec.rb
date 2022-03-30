require 'rails_helper'

RSpec.describe DisasterReport, type: :model do
  let!(:disaster_report) { described_class.new(latitude: -33.5123, longitude: -33.5123, disaster_level: 'Moderate', description: 'This is a description', date_occured: Time.zone.now) }
  let(:disaster) { create(:disaster) }
  let(:user) { create(:user) }

  it 'has a latitude' do
    disaster_report.latitude = nil
    disaster_report.disaster = disaster

    expect(disaster_report).not_to be_valid
  end

  it 'has a longitude' do
    disaster_report.longitude = nil
    disaster_report.disaster = disaster

    expect(disaster_report).not_to be_valid
  end

  it 'has a disaster_level' do
    disaster_report.disaster_level = nil
    disaster_report.disaster = disaster

    expect(disaster_report).not_to be_valid
  end

  it 'has a description' do
    disaster_report.disaster = disaster
    disaster_report.description = nil

    expect(disaster_report).not_to be_valid
  end

  it 'has a date_occured' do
    disaster_report.date_occured = 'okasdf'

    expect(disaster_report).not_to be_valid
  end
end
