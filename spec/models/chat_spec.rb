require 'rails_helper'
RSpec.describe 'Postモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { post.valid? }
    
    let(:user) { create(:user) }
    let!(:post) { build(:post, user_id: user.id) }
    
    context 'bodyカラム' do
      it '空欄でないこと' do
        post.body = ""
        is_expected.to eq false
      end
    end
  end

RSpec.describe 'Chatモデルのテスト', type: :model do
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Chat.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'Roomモデルとの関係' do
      it 'N:1となっている' do
        expect(Chat.reflect_on_association(:room).macro).to eq :belongs_to
      end
    end
    context 'Notificationモデルとの関係' do
      it '1:Nとなっている' do
        expect(Chat.reflect_on_association(:notifications).macro).to eq :has_many
      end
    end
  end
end