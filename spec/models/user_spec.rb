require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { described_class.new }

  it 'has a first name' do
    user.first_name = nil
    user.last_name = 'last name'
    user.email = 'josh@gmail.com'
    user.password = '123456'

    expect(user).not_to be_valid
  end

  it 'has a last name' do
    user.first_name = 'first name'
    user.last_name = nil
    user.email = 'josh@gmail.com'
    user.password = '123456'

    expect(user).not_to be_valid
  end

  it 'has a valid email' do
    user.first_name = 'first name'
    user.last_name = 'last name'
    user.email = 'testing'
    user.password = '123456'

    expect(user).not_to be_valid
  end

  it 'has an email' do
    user.first_name = 'first name'
    user.last_name = 'last name'
    user.email = nil
    user.password = '123456'

    expect(user).not_to be_valid
  end

  it 'has a password' do
    user.first_name = 'first name'
    user.last_name = 'last name'
    user.email = 'josh@gmail.com'
    user.password = nil

    expect(user).not_to be_valid
  end
end
