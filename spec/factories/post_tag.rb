FactoryBot.define do
  factory :post_tag do
    tag_id {FactoryBot.create(:tag).id}
    post_id {FactoryBot.create(:post).id}
  end
end