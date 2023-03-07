class Admin::TagsController < ApplicationController

    def index
        @tag = Tag.new
        @tags = Tag.all
    end

    def create
        @tag = Tag.new(tag_params)
        if @tag.save
            redirect_to request.referer, notice: "タグを追加しました。"
        else
            @tags = Tag.all
            render :index
        end
    end
    
    private

    def tag_params
        params.require(:tag).permit(:tag_name)
    end

end
