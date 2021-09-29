class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_post,only: [:edit, :update]

  def new
    @regions = Region.where.not(ancestry: nil)
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    tag_list = params[:post][:tag_name].split(",") #送られてきた値を,で区切って配列化
    if !params[:post][:camp_site_id].blank? #region_idがブランク（選択してくださいのまま）である場合は@post.saveのバリデーションで弾く
      @camp_site = CampSite.where(id: params[:post][:camp_site_id]).first
      @post.camp_site_id = @camp_site.id
    end
    if @post.save
      @post.save_tag(tag_list)
      redirect_to posts_path, notice: "投稿しました"
    else
      @regions = Region.where.not(ancestry: nil)
      render :new
    end
  end

  def index
    @posts = Post.all.order(created_at: :desc)
    @tag_list = Tag.find(PostTag.group(:tag_id).order('count(tag_id) desc').limit(10).pluck(:tag_id))
  end

  def followed_index
    @tag_list = Tag.find(PostTag.group(:tag_id).order('count(tag_id) desc').limit(10).pluck(:tag_id))
    @followed_user = Relationship.where(follower_id: current_user.id).pluck("followed_id")
    @posts = Post.where(user_id: @followed_user).order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @post_comment = PostComment.new
    @post_comments = PostComment.all.order(created_at: :desc)
    @post_tags = @post.tags
  end

  def edit
    @post = Post.find(params[:id])
    @user = @post.user
    @tag_list = @post.tags.pluck(:tag_id).join(",")
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)# && @post.user_id == current_user.id
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
    @post.destroy# if @post.user_id == current_user.id
    redirect_to posts_path
  end

  def search
    @tag_list = Tag.find(PostTag.group(:tag_id).order('count(tag_id) desc').limit(10).pluck(:tag_id))
    @tag = Tag.find(params[:tag_id])
    @posts = @tag.posts.all
  end

  private

  def post_params
    params.require(:post).permit(:image, :body).merge(user_id: current_user.id)
  end

  def ensure_correct_post
    @post = Post.find(params[:id])
    @user = @post.user
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

  def camp_site_params
    params.require(:post).permit(:camp_site_id)
  end

end
