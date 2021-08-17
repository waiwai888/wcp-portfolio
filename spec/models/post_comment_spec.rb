require 'rails_helper'

RSpec.describe 'PostCommentモデルのテスト' do
  describe 'バリデーションのテスト' do
    subject { post_comment.valid? }
    
    let(:user) { create(:user) }
    let(:post) { create(:post) }
    let!(:post_comment) { build(:post_comment, user_id: user.id, post_id: post.id) }
    
    context 'commentカラムのテスト' do
      it '空欄でないこと' do
        post_comment.comment = ""
        is_expected.to eq false
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(PostComment.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'Postモデルとの関係' do
      it 'N:1となっている' do
        expect(PostComment.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end
    context 'PostTagモデルとの関係' do
      it '1:Nとなっている' do
        expect(PostComment.reflect_on_association(:post_tags).macro).to eq :has_many
      end
    end
  end
end
  