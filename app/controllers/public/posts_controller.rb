class Public::PostsController < ApplicationController
    def new
        @post = Post.new
        @tag = Tag.all
    end

    def create
        @post = Post.new(post_parame)
        @post.user_id = current_user.id
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

end
