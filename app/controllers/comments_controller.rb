class CommentsController < ApplicationController
  before_action :authenticate_user

  def create
    @post = Post.find_by(id: params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user_id = @current_user.id
     if @comment.save
      render "/comments/js"
     end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      render "/comments/js"
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:body, :post_id, :user_id)
    end


end
