class PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    tag_list = params[:post][:tag_name].split(",") #送られてきた値を,で区切って配列化
    if @post.save
      @post.save_tag(tag_list)
      redirect_to posts_path, notice: "successfully"
    else
      render :new
    end
  end

  def index
    @posts = Post.all
    @tag_list = Tag.all
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
    tag_list = params[:post][:tag_name].split(",")
    if @post.update(post_params)
      @post.save_tag(tag_list)
      redirect_to post_path(@post), notice: "successfully"
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

end
