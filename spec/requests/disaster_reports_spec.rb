require 'rails_helper'

RSpec.describe "DisasterReports", type: :request do
  let(:auth_headers) do
    user = create(:user)
    headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }

    Devise::JWT::TestHelpers.auth_headers(headers, user)
  end
  let!(:disaster) { create(:disaster) }

  describe "GET /disaster_reports" do
    let!(:reports) { create(:disaster_report) }
    it "returns all approved reports" do
      get '/api/v1/disaster_reports', headers: auth_headers

      expect(JSON.parse(response.body).length).to eq(1)
    end
  end

  describe 'GET /pending_reports' do
    let!(:pendings) { create(:pending_report) }
    it 'returns all unapproved reports' do
      get '/api/v1/pending_reports', headers: auth_headers

      expect(JSON.parse(response.body).length).to eq(1)
    end
  end

  describe "GET /disaster_reports/:id" do
    let!(:report) { create(:disaster_report) }
    it 'returns a report' do
      get "/api/v1/disaster_reports", headers: auth_headers

      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /disaster_reports" do
    it "creates a disaster report" do
      post '/api/v1/disaster_reports', params: { description: 'this is a description', disaster_level: 'Danger', date_occured: Time.zone.now, latitude: 10.321, longitude: 123.5678, disaster_id: disaster.id }.to_json, headers: auth_headers

      expect(response).to have_http_status(:created)
    end
  end

  describe "PUT /disaster_reports/:id" do
    let!(:report) { create(:disaster_report) }
    it 'updates a report' do
      put "/api/v1/disaster_reports/#{report.id}", params: { description: 'updated description'}.to_json, headers: auth_headers

      expect(response).to have_http_status(:ok)
    end
  end
  
  describe "DELETE /disaster_reports/:id" do
    let!(:report) { create(:disaster_report) }
    it "deletes a report" do
      delete "/api/v1/disaster_reports/#{report.id}", headers: auth_headers
      expect(response).to have_http_status(:no_content)
    end
    
  end

  describe "PUT /disaster_reports/:id/vote" do
    let!(:report) { create(:disaster_report) }
    it 'votes/unvotes a report' do
      put "/api/v1/disaster_reports/#{report.id}/vote", headers: auth_headers
    end
  end
  
  
end
