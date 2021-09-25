class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc).page(params[:page]).per(6)
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(current_user), notice: "登録情報を更新しました"
    else
      render :edit
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :nickname, :account_name, :introduction, :profile_image)
  end
  
  def ensure_correct_user
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user)
    end
  end
  
end
