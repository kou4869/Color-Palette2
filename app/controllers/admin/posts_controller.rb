class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    #タグ検索用の記述
    if params[:tag_id].present?
      tag = Tag.find(params[:tag_id])
      @posts = tag.posts
      @tag_name = tag.tag_name
    else
      @posts = Post.all
    end

    #並び替え用の記述
    if params[:latest]
      @posts = @posts.latest
    elsif params[:old]
      @posts = @posts.old
    else
      @posts = @posts.all
    end
    
    @posts = @posts.page(params[:page]).per(4)
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path
  end

end
