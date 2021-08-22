require 'rails_helper'

RSpec.describe 'PostTagモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { post_tag.valid? }
    
    let(:user) { create(:user) }
    let(:post) { create(:post, user_id: user.id) }
    let(:tag) { create(:tag) }
    let!(:post_tag) { create(:post_tag, tag_id: tag.id, post_id: post.id ) }
    
    context 'post_idカラムのテスト' do
      it '空欄でないこと' do
        post_tag.post_id = ""
        is_expected.to eq false
      end
    end
    context 'tag_idカラムのテスト' do
      it '空欄でないこと' do
        post_tag.tag_id = ""
        is_expected.to eq false
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Postモデルとの関係' do
      it 'N:1となっている' do
        expect(PostTag.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end
    context 'Tagモデルとの関係' do
      it 'N:1となっている' do
        expect(PostTag.reflect_on_association(:tag).macro).to eq :belongs_to
      end
    end
    
  end
end