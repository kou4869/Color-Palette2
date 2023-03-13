class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @comments = Comment.page(params[:page]).per(8).order(created_at: "DESC")
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_back(fallback_location: root_path)
  end

end
