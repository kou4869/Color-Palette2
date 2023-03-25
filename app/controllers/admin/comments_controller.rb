class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @comments = Comment.all

    if params[:latest]
      @comments = Kaminari.paginate_array(@comments.latest).page(params[:page]).per(8)
    elsif params[:old]
      @comments = Kaminari.paginate_array(@comments.old).page(params[:page]).per(8)
    else
      @comments = Kaminari.paginate_array(@comments.latest).page(params[:page]).per(8)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:notice] = "コメントを削除しました"
    redirect_back(fallback_location: root_path)
  end

end
