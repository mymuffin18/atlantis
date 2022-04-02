require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe 'Users', type: :request do
  let(:auth_headers) do
    admin = create(:admin)
    headers = { 'Accept' => 'application/json', 'Content-type' => 'application/json' }
    Devise::JWT::TestHelpers.auth_headers(headers, admin)
  end

  describe 'GET /users' do
    it 'returns all users' do
      get '/api/v1/users', headers: auth_headers
      expect(response).to have_http_status(:ok)
    end
  end
end
