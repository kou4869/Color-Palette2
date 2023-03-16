class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def index
    @users = User.page(params[:page]).per(8).order(created_at: "DESC")
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user)
    else
      render :show
    end    
  end

  def destroy
    @user = User.find(params[:id]) 
    @user.destroy
    flash[:notice] = 'ユーザーを削除しました。'
    redirect_back(fallback_location: root_path)
  end


  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
