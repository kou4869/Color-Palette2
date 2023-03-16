class Public::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy]

  def index
    @user = User.find(params[:user_id])
    
    if params[:tag_id].present?
      tag = Tag.find(params[:tag_id])
      @posts = tag.posts
      @tag_name = tag.tag_name
    else
      @posts = @user.posts
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
    
    #@posts = @posts.page(params[:page]).per(8)
  end

  def edit
    @post = Post.find(params[:id])
  end


  def like
    @user = User.find(params[:user_id])
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.where(favorites).page(params[:page]).per(4)
  end

  def quit
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_my_page_path, notice: "プロフィールを更新しました"
    else
      render :edit
    end    
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path
  end


  private

  def user_params
      params.require(:user).permit(:name, :introduction, :profile_image)
  end


end
