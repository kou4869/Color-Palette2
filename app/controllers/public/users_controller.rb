class Public::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy]
  before_action :ensure_guest_user, only: [:edit, :update, :destroy]

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts

    if params[:tag_id].present?
      tag = Tag.find(params[:tag_id])
      @posts = @posts.where(id: tag.posts.ids)
      @tag_name = tag.tag_name
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
    #   @posts = @posts.order(avarage_star: :desc)
    # end

    @posts = @posts.user_posts(params[:sort], params[:page], 8)
    # @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(8)
  end

  def like
    @user = User.find(params[:user_id])
    @favorites = @user.favorites
    # ユーザーのブックマークの中のpost_idだけを抽出してる（中身が欲しいのでPostに渡してあげている）
    @favorite_posts = Post.where(id: @favorites.pluck(:post_id))


    if params[:tag_id].present?
      tag = Tag.find(params[:tag_id])
      @favorite_posts = Post.where(id: (@favorite_posts.ids & tag.posts.ids))
      @tag_name = tag.tag_name
    end

    # params[:sort]が空である場合、(パラメータが渡されていない場合)params[:sort]にはデフォルト値として"latest"を設定
    # params[:sort] = params[:sort].blank? ? "latest" : params[:sort]

    #並び替えとタグ検索を同時に行うための記述
    # case params[:sort]
    # when "latest"
    #   @favorite_posts = @favorite_posts.order(created_at: :desc)
    # when "oldest"
    #   @favorite_posts = @favorite_posts.order(created_at: :asc)
    # when "avarage_star"
    #   @favorite_posts = @favorite_posts.order(avarage_star: :desc)
    # end

    @favorite_posts = @favorite_posts.user_posts(params[:sort], params[:page], 8)
    # @favorite_posts = Kaminari.paginate_array(@favorite_posts).page(params[:page]).per(8)
  end

  def quit
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_my_page_path, notice: "プロフィールを更新しました"
    else
      flash[:alert] = "必須項目を入力してください"
      flash[:error] = @user.errors.full_messages.join(", ")
      render :edit
    end
  end

  def destroy
    @user = current_user
    @user.destroy
    redirect_to root_path, notice: "登録データの削除が完了しました。ご利用いただきまして、誠にありがとうございました。"
  end


  private

  def user_params
      params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_guest_user
    @user = User.find(params[:user_id])
    if @user.name == "guestuser"
      redirect_to posts_path , notice: "ゲストユーザーはプロフィールを編集できません。"
    end
  end


end
