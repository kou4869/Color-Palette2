class  Public::CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_back(fallback_location: root_path, notice: "コメントを送信しました")
    else
      @user = current_user
      @comments = @post.comments.where(parent_id: nil).order(created_at: :desc) # コメント一覧表示で使用する全コメントデータ新着順で表示
      # byebug
      flash[:error] = "コメント・返信は150文字以内でご入力してください"
      render 'public/posts/show'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_back(fallback_location: root_path, notice: "コメントを削除しました")
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :star, :post_id, :user_id, :parent_id)
  end

end