FactoryBot.define do
  factory :user do
    first_name { 'test' }
    last_name { 'last_name' }
    email { 'abc@gmail.com' }
    password { 'testing' }
  end
end
