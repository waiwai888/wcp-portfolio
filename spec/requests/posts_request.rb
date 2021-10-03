require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "[Action test]" do
    before do
      @user = FactoryBot.create(:user)
    end
    #newアクション
    context "new" do
      it "access by user" do
        sign_in @user
        get '/posts/new'
        expect(response).to be_successful
      end
    end
  end
end