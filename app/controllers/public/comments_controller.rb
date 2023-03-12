class  Public::CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id]) 
    @comment = @post.comments.new(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    redirect_back(fallback_location: root_path)
  end
    
  def destroy
    Comment.find(params[:id]).destroy
    redirect_back(fallback_location: root_path)
  end
    
  private
    
  def comment_params
    params.require(:comment).permit(:comment, :post_id, :user_id, :parent_id)
  end

end
