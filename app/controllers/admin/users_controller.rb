class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @user = User.find(params[:id])
    @posts = Kaminari.paginate_array(@user.posts).page(params[:page]).per(8)
  end

  def index
    if params[:latest]
      @users = User.latest
    elsif params[:old]
      @users = User.old
    else
      @users = Kaminari.paginate_array(User.all).page(params[:page]).per(8)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "ユーザー情報を編集しました"
    else
      flash.now[:alert] ="未入力箇所があります"
      render :show
    end    
  end

  def destroy
    @user = User.find(params[:id]) 
    @user.destroy
    flash.now[:notice] = "ユーザーを削除しました"
    redirect_to admin_users_path
  end


  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
