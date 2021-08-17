FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number: 10) }
    email { Faker::Internet.email }
    nickname { Faker::Lorem.characters(number: 10) }
    account_name { Faker::Lorem.characters(number: 10) }
    password { 'password' }
    password_confirmation { 'password' }
  end
end