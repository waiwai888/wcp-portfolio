FactoryBot.define do
  factory :post_comment do
    comment { Faker::Lorem.characters(number: 5) }
    post
    user
  end
end