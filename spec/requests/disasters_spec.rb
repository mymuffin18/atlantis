require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe 'Disasters', type: :request do
  let(:auth_headers) do
    admin = create(:admin)
    headers = { 'Accept' => 'applucation/json', 'Content-type' => 'applicarion/json' }
    Devise::JWT::TestHelpers.auth_headers(headers, admin)
  end

  describe 'GET /disasters' do
    it 'returns all disaster type' do
      get '/api/v1/disasters', headers: auth_headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /disasters' do
    it 'creates new disaster type' do
      post '/api/v1/disasters', params: { disaster_type: 'disaster type', avatar: fixture_file_upload('app/assets/images/default-profile.jpg', 'image/jpg') }, headers: auth_headers
      expect(response).to have_http_status(:created)
    end
  end

  describe 'GET /disasters/:id' do
    let!(:disaster) { Disaster.create(disaster_type: 'disaster type', avatar: fixture_file_upload('app/assets/images/default-profile.jpg', 'image/jpg')) }

    it 'shows the specific disaster type' do
      get "/api/v1/disasters/#{disaster.id}", headers: auth_headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PUT /disasters/:id' do
    let!(:disaster) { Disaster.create(disaster_type: 'disaster type', avatar: fixture_file_upload('app/assets/images/default-profile.jpg', 'image/jpg')) }

    it 'updates disaster type' do
      put "/api/v1/disasters/#{disaster.id}", params: { disaster_type: 'disaster type', avatar: fixture_file_upload('app/assets/images/default-profile.jpg', 'image/jpg') }, headers: auth_headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'DELETE /disasters/:id' do
    let!(:disaster) { Disaster.create(disaster_type: 'disaster type', avatar: fixture_file_upload('app/assets/images/default-profile.jpg', 'image/jpg')) }

    it 'deletes disaster type' do
      delete "/api/v1/disasters/#{disaster.id}", headers: auth_headers
      expect(response).to have_http_status(:no_content)
    end
  end
end
