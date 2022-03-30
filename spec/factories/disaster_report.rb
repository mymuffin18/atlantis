FactoryBot.define do
  factory :disaster_report do
    user factory: :user_two
    disaster factory: :disaster
    disaster_level { 'Danger' }
    longitude { 10.50 }
    latitude { 20.0 }
    date_occured { Time.zone.now }
    description { 'Description' }
    approved_by { 'Josh uy' }
    approved { true }
    images { Rack::Test::UploadedFile.new('app/assets/images/default-profile.jpg', 'image/jpg') }
  end

  factory :pending_report, class: 'DisasterReport' do
    user factory: :user_two
    disaster factory: :disaster
    disaster_level { 'Danger' }
    longitude { 10.50 }
    latitude { 20.0 }
    date_occured { Time.zone.now }
    description { 'Description' }
    approved_by { nil }
    approved { false }
    images { Rack::Test::UploadedFile.new('app/assets/images/default-profile.jpg', 'image/jpg') }
  end
end
