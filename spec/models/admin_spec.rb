require 'rails_helper'

RSpec.describe Admin, type: :model do
  let!(:admin) { described_class.new }

  it 'has a first name' do
    admin.first_name = nil
    admin.last_name = 'last name'
    admin.email = 'josh@gmail.com'
    admin.password = '123456'

    expect(admin).not_to be_valid
  end

  it 'has a last name' do
    admin.first_name = 'first name'
    admin.last_name = nil
    admin.email = 'josh@gmail.com'
    admin.password = '123456'

    expect(admin).not_to be_valid
  end

  it 'has a valid email' do
    admin.first_name = 'first name'
    admin.last_name = 'last name'
    admin.email = 'testing'
    admin.password = '123456'

    expect(admin).not_to be_valid
  end

  it 'has an email' do
    admin.first_name = 'first name'
    admin.last_name = 'last name'
    admin.email = nil
    admin.password = '123456'

    expect(admin).not_to be_valid
  end

  it 'has a password' do
    admin.first_name = 'first name'
    admin.last_name = 'last name'
    admin.email = 'josh@gmail.com'
    admin.password = nil

    expect(admin).not_to be_valid
  end
end
