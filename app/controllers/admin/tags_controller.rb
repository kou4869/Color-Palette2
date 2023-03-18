class Admin::TagsController < ApplicationController

  def index
    @tag = Tag.new
    
    if params[:latest]
      @tags = Tag.latest.page(params[:page])
    elsif params[:old]
      @tags = Tag.old.page(params[:page])
    else
      @tags = Kaminari.paginate_array(Tag.all).page(params[:page]).per(10)
    end
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to request.referer, notice: "タグを追加しました"
    else
      @tags = Tag.all
      flash.now[:alert] = "必須項目を入力してください"
      render :index
    end
  end

  def update
    @tag = Tag.find(params[:id])
    @tag.update(tag_params)
    flash.now[:notice] = "変更を保存しました"
    redirect_back(fallback_location: root_path)
  end
  
  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    flash.now[:notice] = "タグを削除しました"
    redirect_back(fallback_location: root_path)
  end

  private

  def tag_params
    params.require(:tag).permit(:tag_name)
  end

end
