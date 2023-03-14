class Public::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy]

  def index
    @user = User.find(params[:user_id])
    @post = @user.posts
  end

  def like
    @user = User.find(params[:user_id])
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
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
