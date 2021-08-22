FactoryBot.define do
  factory :post do
    body { Faker::Lorem.characters(number: 20) }
    user
    after(:create) do |post|
      create_list(:post_tag, 1, post: post, tag: create(:tag))
    end
  end
end