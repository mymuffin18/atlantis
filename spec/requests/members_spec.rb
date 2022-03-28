require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe "Members", type: :request do
  let(:auth_headers) do
    user = create(:user)
    headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }

    Devise::JWT::TestHelpers.auth_headers(headers, user)
  end

  
  describe "GET /members" do
    it 'returns the logged in user' do
      get '/api/v1/members', headers: auth_headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /members/:id" do
    let!(:user) { User.create(first_name: 'first', last_name: 'last', email: 'first@example.com', password: '123456')}
    it 'returns a user' do
      get "/api/v1/members/#{user.id}", headers: auth_headers
      expect(response).to have_http_status(:ok)
    end
  end
  
end
