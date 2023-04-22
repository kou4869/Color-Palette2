class Public::PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :is_matching_login_user, only: [:edit, :update]

  def new
    @post = Post.new
    @tag = Tag.all
  end

  def create
    @post = Post.new(post_params)
    if (1..4).exclude?(@post.tags.length)
      flash[:my_alert] = "タグは１～４個まで設定できます。"
      render :new
      return
    end
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post), notice: "新しい配色を投稿しました"
    else
      flash[:alert] = "必須項目を入力してください"
      flash.now[:error] = @post.errors.full_messages.join(", ")
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_stay_avarage = @post.avarage_star
    @user = @post.user
    @comment = Comment.new
    @comment_reply = Comment.new
    @comments = @post.comments.where(parent_id: nil).order(created_at: :desc) # コメント一覧表示で使用する全コメントデータ新着順で表示
  end

  def index
    @user = current_user

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

    # 並び替えとタグ検索を同時に行うための記述
    # case params[:sort]
    # when "latest"
    #   @posts = @posts.order(created_at: :desc)
    # when "oldest"
    #   @posts = @posts.order(created_at: :asc)
    # when "avarage_star"
    #   @posts = @posts.sort_by { |a| a.avarage_star }.reverse
    # end

    @posts = Post.sort_posts(params[:sort], params[:page], 8)
    # @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(8)
  end

  def edit
    @user = current_user
    @post = Post.find(params[:id])
    if (1..4).exclude?(@post.tags.length)
      flash[:my_alert] = "タグは１～４個まで設定できます。"
      render :edit
      return
    end
  end

  def update
    @post = Post.find(params[:id])
    new_tags = post_params[:tag_ids].reject(&:blank?)

    if new_tags.empty? || new_tags.length > 4
      flash[:my_alert] = "タグは１～４個まで設定できます。"
      render :edit
      return
    end

    @post.tag_ids = new_tags
    if @post.update(post_params.except(:tag_ids))
      redirect_to post_path(@post), notice: "更新が完了しました"
    else
      flash[:alert] = "必須項目を入力してください"
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_back(fallback_location: root_path, notice: "投稿を削除しました")
  end

  private

  def post_params
    params.require(:post).permit(:color1, :color2, :color3, :color4, :post_introduction, {tag_ids: []})
  end

  def is_matching_login_user
    user = Post.find(params[:id]).user  #ポストを投稿したユーザーの情報
    unless user.id == current_user.id
      redirect_to post_path(params[:id])
    end
  end

end
