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
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Post.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'Favoriteモデルとの関係' do
      it '1:Nとなっている' do
        expect(Post.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end
    context 'PostCommentモデルとの関係' do
      it '1:Nとなっている' do
        expect(Post.reflect_on_association(:post_comments).macro).to eq :has_many
      end
    end
    context 'Notificationモデルとの関係' do
      it '1:Nとなっている' do
        expect(Post.reflect_on_association(:notifications).macro).to eq :has_many
      end
    end
    context 'PostTagモデルとの関係' do
      it '1:Nとなっている' do
        expect(Post.reflect_on_association(:post_tags).macro).to eq :has_many
      end
    end
    context 'Tagモデルとの関係' do
      it '1:Nとなっている' do
        expect(Post.reflect_on_association(:tags).macro).to eq :has_many
      end
    end
    
  end
end