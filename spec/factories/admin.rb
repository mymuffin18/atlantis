FactoryBot.define do
    factory :admin do
      first_name { 'test' }
      last_name { 'last_name' }
      email { 'abc@gmail.com' }
      password { 'testing' }
    end
  end
