class Users::SessionsController < ApplicationController
  
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to posts_followed_index_path, notice: 'ゲストユーザーとしてログインしました。'
  end
  
end
