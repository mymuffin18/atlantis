require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe 'Locations', type: :request do
  let(:auth_headers) do
    user = create(:user)
    headers = { 'Accept' => 'application/json', 'Content-type' => 'application/json' }
    Devise::JWT::TestHelpers.auth_headers(headers, user)
  end

  let(:user) { User.create(first_name: 'josh', last_name: 'uy', email: 'josh@email.com', password: '123456') }

  describe 'GET /locations' do
    it 'returns all pin locations of the current user' do
      get '/api/v1/locations', headers: auth_headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /locations' do
    it 'creates new pin location' do
      post '/api/v1/locations', params: { locname: 'location name', latitude: 0, longitude: 0 }.to_json, headers: auth_headers
      expect(response).to have_http_status(:created)
    end
  end

  describe 'GET /locations/:id' do
    let!(:location) { Location.create(locname: 'location name', latitude: 0, longitude: 0) }

    it 'shows the specific pin location' do
      get "/api/v1/locations/#{location.id}", headers: auth_headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PUT /locations/:id' do
    let!(:location) { Location.create(locname: 'location name', latitude: 0, longitude: 0, user: user) }

    it 'updates location name' do
      put "/api/v1/locations/#{location.id}", params: { locname: 'location name' }.to_json, headers: auth_headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'DELETE /locations/:id' do
    let!(:location) { Location.create(locname: 'location name', latitude: 0, longitude: 0, user: user) }

    it 'deletes location' do
      delete "/api/v1/locations/#{location.id}", headers: auth_headers
      expect(response).to have_http_status(:no_content)
    end
  end
end
