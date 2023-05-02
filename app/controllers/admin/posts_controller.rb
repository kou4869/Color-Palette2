class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @posts = Post.all

  #タグ検索用の記述
    if params[:tag_id].present?
      tag = Tag.find(params[:tag_id])
      @posts = tag.posts
      @tag_name = tag.tag_name
    end

    @posts = Post.sort_posts(params[:sort], @posts)
    @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(8)
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @comments = @post.comments.where(parent_id: nil).order(created_at: :desc) # コメント一覧表示で使用する全コメントデータ新着順で表示
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to admin_post_path(@post), notice: "更新が完了しました"
    else
      render :show
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path, notice: "投稿を削除しました"
  end

  private

  def post_params
    params.require(:post).permit(:post_introduction)
  end


end
