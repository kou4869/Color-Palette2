class Public::TagsController < ApplicationController
  before_action :authenticate_user!, only: [:crete]
  
  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to request.referer, notice: "タグを追加しました"
    else
      render 'public/posts/new'
    end
  end
  
  
  private

  def tag_params
    params.require(:tag).permit(:tag_name)
  end
  
  
end
