require 'rails_helper'

RSpec.describe 'UserRoomモデルのテスト', type: :model do
  describe 'アソシエーションのテスト' do
    context 'UserRoomモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:user_rooms).macro).to eq :has_many
      end
    end
    context 'Chatモデルとの関係' do
      it '1:Nとなっている' do
        expect(Room.reflect_on_association(:chats).macro).to eq :has_many
      end
    end
    context 'Notificationモデルとの関係' do
      it '1:Nとなっている' do
        expect(Room.reflect_on_association(:notifications).macro).to eq :has_many
      end
    end
  end
end