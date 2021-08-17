require 'rails_helper'

RSpec.describe 'Notificationモデルのテスト', type: :model do
  describe 'アソシエーションのテスト' do
    context 'Postモデルとの関係' do
      it 'N:1となっている' do
        expect(Notification.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Notification.reflect_on_association(:visiter).macro).to eq :belongs_to
      end
      it 'N:1となっている' do
        expect(Notification.reflect_on_association(:visited).macro).to eq :belongs_to
      end
    end
    context 'Roomモデルとの関係' do
      it 'N:1となっている' do
        expect(Notification.reflect_on_association(:room).macro).to eq :belongs_to
      end
    end
    context 'Chatモデルとの関係' do
      it 'N:1となっている' do
        expect(Notification.reflect_on_association(:chat).macro).to eq :belongs_to
      end
    end
  end
end