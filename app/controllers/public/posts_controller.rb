class Public::PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]

  def new
    @post = Post.new
    @tag = Tag.all
  end

  def create
    @post = Post.new(post_params)
    if (1..5).exclude?(@post.tags.length)
      flash.now[:my_alert] = "タグは１～５個まで設定できます。"
      render :new
      return
    end
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_stay_avarage = @post.avarage_stay
    @user = @post.user
    @comment = Comment.new
    @comment_reply = Comment.new
    @comments = @post.comments.where(parent_id: nil).order(created_at: :desc) # コメント一覧表示で使用する全コメントデータ新着順で表示
  end

  def index
    @user = current_user
    @posts = Post.page(params[:page]).per(8)
    @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : Post.all
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "更新が完了しました！"
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:color1, :color2, :color3, :color4, :post_introduction, {tag_ids: []})
  end


end
