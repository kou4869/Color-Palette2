class Public::PostsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]

    def new
        @post = Post.new
        @tag = Tag.all
    end

    def create
        @post = Post.new(post_params)
        if @post.tags.length > 5
            flash.now[:alert] = "タグは１～５個まで設定できます。"
            render :new
            return
        end
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
        @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : Post.all
    end

    def edit
    end

    def update
    end

    def destroy
    end

    private

    def post_params
        params.require(:post).permit(:color1, :color2, :color3, :color4, :post_introduction, {tag_ids: []})
    end


end
