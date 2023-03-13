class Public::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy]

  def show
    @user = current_user
  end

  def index
  end

  def like
  end

  def quit
  end

  def edit
      @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to users_my_page_path, notice: "プロフィールを更新しました"
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
