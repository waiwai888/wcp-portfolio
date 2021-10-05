FactoryBot.define do
  factory :post do
    body { Faker::Lorem.characters(number: 20) }
    camp_site_id '1'
    user
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/no_image.png')) }
    after(:create) do |post|
      create_list(:post_tag, 1, post: post, tag: create(:tag))
    end
  end
end