require 'rails_helper'

RSpec.describe 'Tagモデルのテスト', type: :model do
  let(:tag) { create(:tag) }
  let(:user) { create(:user) }
  let(:post) { create(:post, user_id: user.id) }
  let(:post_tag) { create(:post_tag, post_id: post.id, tag_id: tag.id) }
  
  describe 'アソシエーションのテスト' do
    context 'Postモデルとの関係' do
      it '1:Nとなっている' do
        expect(Tag.reflect_on_association(:posts).macro).to eq :has_many
      end
    end
    context 'PostTagモデルとの関係' do
      it '1:Nとなっている' do
        expect(Tag.reflect_on_association(:post_tags).macro).to eq :has_many
      end
    end
  end
end