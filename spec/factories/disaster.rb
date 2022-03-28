FactoryBot.define do
  factory :disaster do
    disaster_type { 'Tornado' }
    avatar { Rack::Test::UploadedFile.new('app/assets/images/default-profile.jpg', 'image/jpg')}
  end
end
