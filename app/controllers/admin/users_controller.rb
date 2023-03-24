class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @posts = @posts.order(created_at: :desc)
    @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(8)
  end

  def index
    @users = User.all
    
    if params[:latest]
      @users = Kaminari.paginate_array(@users.latest).page(params[:page]).per(12)
    elsif params[:old]
      @users = Kaminari.paginate_array(@users.old).page(params[:page]).per(12)
    else
      @users = Kaminari.paginate_array(@users.latest).page(params[:page]).per(12)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "ユーザー情報を編集しました"
    else
      flash[:alert] ="未入力箇所があります"
      flash[:error] = @user.errors.full_messages.join(", ")
      render :show
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: "ユーザーを削除しました"
  end


  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
