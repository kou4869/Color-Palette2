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

  # #タグ検索用の記述
  if params[:tag_id].present?
    tag = Tag.find(params[:tag_id])
    @posts = tag.posts
    @tag_name = tag.tag_name
  else
    @posts = Post.all
  end

  #並び替えとタグ検索を同時に行うための記述
  @posts = @posts.where(tags: params[:tag]) if params[:tag].present?
  case params[:sort]
  when "latest"
    @posts = @posts.order(created_at: :desc)
  when "oldest"
    @posts = @posts.order(created_at: :asc)
  when "avarage_stay"
    @posts = @posts.order(avarage_stay: :desc)
  end
    
    @posts = @posts.page(params[:page]).per(8)
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
