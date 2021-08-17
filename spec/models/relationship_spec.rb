require 'rails_helper'

RSpec.describe 'Relationshipモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { relationship.valid? }
    
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }
    let!(:relationship) { user.relationships.build(followed_id: other_user.id) }
    
    context 'follower_id' do
      it '空欄でないこと' do
        relationship.follower_id = ""
        is_expected.to eq false
      end
    end
    context 'followed_id' do
      it '空欄であること' do
        relationship.followed_id = ""
        is_expected.to eq false
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Relationship.reflect_on_association(:follower).macro).to eq :belongs_to
      end
      it 'N:1となっている' do
        expect(Relationship.reflect_on_association(:followed).macro).to eq :belongs_to
      end
    end
  end
end