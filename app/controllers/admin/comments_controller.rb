class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    if params[:latest]
      @comments = Comment.latest.page(params[:page])
    elsif params[:old]
      @comments = Comment.old.page(params[:page])
    else
      @comments = Kaminari.paginate_array(Comment.all).page(params[:page]).per(6)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash.now[:notice] = "コメントを削除しました"
    redirect_back(fallback_location: root_path)
  end

end
