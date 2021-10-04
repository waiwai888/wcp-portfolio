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
  describe "index" do
    #未ログインユーザーの場合
    context "as a user not to login" do
      # indexアクション後ログインページへ遷移
      it "redirects to the sign-in page" do
        get '/posts'
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
  describe "show" do
    #未ログインユーザーの場合
    context "as a user not to login" do
      # showアクション後ログインページへ遷移
      it "redirects to the sign-in page" do
        get '/posts/:id'
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
  describe "show" do
    #未ログインユーザーの場合
    context "as a user not to login" do
      # showアクション後ログインページへ遷移
      it "redirects to the sign-in page" do
        get '/posts/:id'
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
  describe "followed_index" do
    #未ログインユーザーの場合
    context "as a user not to login" do
      # showアクション後ログインページへ遷移
      it "redirects to the sign-in page" do
        get '/posts/followed_index'
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
  describe "edit" do
    #未ログインユーザーの場合
    context "as a user not to login" do
      # showアクション後ログインページへ遷移
      it "redirects to the sign-in page" do
        get '/posts/:id/edit'
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
end