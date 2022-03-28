require 'rails_helper'

RSpec.describe DisasterReport, type: :model do
  let!(:disaster_report) { described_class.new }
  let(:disaster) { create(:disaster) }
  let(:user) {create(:user)}
  it "has a valid latitude" do
    disaster_report.latitude = nil
    disaster_report.longitude = -33.5123
    disaster_report.disaster_level = "Moderate"
    disaster_report.disaster = disaster
    disaster_report.description = "okay"
    disaster_report.date_occured = Time.zone.now

    expect(disaster_report).not_to be_valid
  end

  it "has a valid longitude" do
    disaster_report.latitude = -33.5123
    disaster_report.longitude = nil
    disaster_report.disaster_level = "Moderate"
    disaster_report.disaster = disaster
    disaster_report.description = "okay"
    disaster_report.date_occured = Time.zone.now

    expect(disaster_report).not_to be_valid
  end

  it "has a valid disaster_level" do
    disaster_report.latitude = -33.5123
    disaster_report.longitude = -33.1234
    disaster_report.disaster_level = nil
    disaster_report.disaster = disaster
    disaster_report.description = "okay"
    disaster_report.date_occured = Time.zone.now

    expect(disaster_report).not_to be_valid
  end

  it "has a valid description" do
    disaster_report.latitude = -33.5123
    disaster_report.longitude = -33.1234
    disaster_report.disaster_level = "Moderate"
    disaster_report.disaster = disaster
    disaster_report.description = nil
    disaster_report.date_occured = Time.zone.now

    expect(disaster_report).not_to be_valid
  end

  it "has a valid date_occured" do
    disaster_report.latitude = -33.5123
    disaster_report.longitude = -33.1234
    disaster_report.disaster_level = "Danger"
    disaster_report.disaster = disaster
    disaster_report.description = "okay"
    disaster_report.date_occured = "okasdf"

    expect(disaster_report).not_to be_valid
  end
end
