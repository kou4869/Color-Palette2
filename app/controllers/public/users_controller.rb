class Public::UsersController < ApplicationController
    before_action :authenticate_customer!

    private

    def user_params
        params.require(:user).permit(:name, :email, :introduction)
    end


end
