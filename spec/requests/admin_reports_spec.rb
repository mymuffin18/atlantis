require 'rails_helper'

RSpec.describe 'AdminReports', type: :request do
  let(:auth_headers) do
    admin = create(:admin)
    headers = { 'Accept' => 'application/json', 'Content-type' => 'application/json' }
    Devise::JWT::TestHelpers.auth_headers(headers, admin)
  end

  describe 'GET /admin_reports' do
    it 'returns all approved reports' do
      create(:disaster_report)
      get '/api/v1/admin_reports', headers: auth_headers
      expect(JSON.parse(response.body).length).to eq(1)
    end
  end

  describe 'GET /pending_reports' do
    it 'returns all pending reports' do
      create(:pending_report)
      get '/api/v1/admins/pending_reports', headers: auth_headers
      expect(JSON.parse(response.body).length).to eq(1)
    end
  end

  describe 'GET /admin_reports/:id' do
    let!(:report) { create(:pending_report) }

    it 'returns a report detail' do
      get "/api/v1/admin_reports/#{report.id}", headers: auth_headers

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PUT /admin_reports/:id/approve' do
    let!(:report) { create(:pending_report) }

    it 'approves/disapprove a report' do
      put "/api/v1/admin_reports/#{report.id}/approve", headers: auth_headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'DELETE /admin_reports/:id' do
    let!(:report) { create(:pending_report) }

    it 'deletees a report' do
      delete "/api/v1/admin_reports/#{report.id}", headers: auth_headers
      expect(response).to have_http_status(:no_content)
    end
  end
end
