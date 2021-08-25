class PostCommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @post_comment = PostComment.new(post_comment_params)
    @post_comment.post_id = @post.id
    @post_comment.user_id = current_user.id
    @comment_post = @post_comment.post
    if @post_comment.save
      @comment_post.create_notification_comment!(current_user, @post_comment.id)
      @post_comment = PostComment.new(post_comment_params)
      @notice = 'コメントしました'
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @post_comment = @post.post_comments.find(params[:id])
    @post_comment.destroy
    flash.now[:notice] = 'コメントを削除しました'
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
