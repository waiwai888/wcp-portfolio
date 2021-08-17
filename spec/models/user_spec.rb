# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { user.valid? }
    let!(:other_user) {create(:user) }
    let(:user) { build(:user) }

    context 'nameカラム' do
      it '空欄でないこと' do
        user.name = ''
        is_expected.to eq false
      end
      it '一意性があること' do
        user.name = other_user.name
        is_expected.to eq false
      end
    end
    context 'account_nameカラム' do
      it '空欄でないこと' do
        user.account_name = ''
        is_expected.to eq false
      end
      it '一意性があること' do
        user.account_name = other_user.account_name
        is_expected.to eq false
      end
      it '６文字以上であること' do
        user.account_name = Faker::Lorem.characters(number: 6)
      end
    end
    context 'nicknameカラム' do
      it '空欄でないこと' do
        user.nickname = ''
        is_expected.to eq false
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Postモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:posts).macro).to eq :has_many
      end
    end
    context 'Favoriteモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end
    context 'UserRoomモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:user_rooms).macro).to eq :has_many
      end
    end
    context 'Chatモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:chats).macro).to eq :has_many
      end
    end
    context 'PostCommentモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:user_rooms).macro).to eq :has_many
      end
    end
    context 'Notificationモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:active_notifications).macro).to eq :has_many
      end
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:passive_notifications).macro).to eq :has_many
      end
    end
    context 'Relationshipモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:reverse_of_relationships).macro).to eq :has_many
      end
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:followers).macro).to eq :has_many
      end
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:relationships).macro).to eq :has_many
      end
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:followings).macro).to eq :has_many
      end
    end
  end
end