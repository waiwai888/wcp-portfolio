class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_post,only: [:edit, :update]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    tag_list = params[:post][:tag_name].split(",") #送られてきた値を,で区切って配列化
    if @post.save
      @post.save_tag(tag_list)
      redirect_to posts_path, notice: "投稿しました"
    else
      render :new
    end
  end

  def index
    @posts = Post.all.order(created_at: :desc)
    @tag_list = Tag.all
    @followed_user = Relationship.where(follower_id: current_user.id).pluck("followed_id")
    @followed_user_posts = Post.where(user_id: @followed_user)
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @post_comment = PostComment.new
    @post_comments = PostComment.all
    @post_tags = @post.tags
  end

  def edit
    @post = Post.find(params[:id])
    @tag_list = @post.tags.pluck(:tag_id).join(",")
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      tag_list = params[:post][:tag_name].split(",")
      @post.save_tag(tag_list)
      redirect_to post_path(@post), notice: "投稿を更新しました"
    else
      @tag_list = @post.tags.pluck(:tag_id).join(",")
      render :edit
    end
  end


  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def search
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    @posts = @tag.posts.all
  end

  private

  def post_params
    params.require(:post).permit(:image, :body)
  end

  def ensure_correct_post
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
