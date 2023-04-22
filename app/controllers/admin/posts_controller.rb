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

    # params[:sort]が空である場合、(パラメータが渡されていない場合)params[:sort]にはデフォルト値として"latest"を設定
    # params[:sort] = params[:sort].blank? ? "latest" : params[:sort]

    #並び替えとタグ検索を同時に行うための記述
    # case params[:sort]
    # when "latest"
    #   @posts = @posts.order(created_at: :desc)
    # when "oldest"
    #   @posts = @posts.order(created_at: :asc)
    # when "avarage_star"
    #   @posts = @posts.sort_by { |a| a.avarage_star }.reverse
    # end

    @posts = @posts.index(params[:sort], params[:page], 8)
    # @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(8)
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
