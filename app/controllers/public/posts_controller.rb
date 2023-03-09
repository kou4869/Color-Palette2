class Public::PostsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]

    def new
        @post = Post.new
        @tag = Tag.all
    end

    def create
        @post = Post.new(post_parame)
        @post.user_id = current_user.id
        if @post.save
            redirect_to post_path(@post)
        else
            render :new
        end
    end

    def show
        @post =Post.find(params[:id])
    end

    def index
        @posts = Post.page(params[:page]).per(8)
    end

    def edit
    end

    def update
    end

    def destroy
    end

    private

    def post_params
        params.require(:post).permit(:color_one, :color_two, :color_three, :color_four, :post_introduction)
    end


end
