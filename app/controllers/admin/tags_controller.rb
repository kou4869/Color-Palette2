class Admin::TagsController < ApplicationController

  def index
    @tag = Tag.new
    @tags = Tag.all
    @tags = @tags.order(created_at: :desc)
    
    if params[:latest]
      @tags = Kaminari.paginate_array(@tags.latest).page(params[:page]).per(8)
    elsif params[:old]
      @tags = Kaminari.paginate_array(@tags.old).page(params[:page]).per(8)
    else
      @tags = Kaminari.paginate_array(@tags).page(params[:page]).per(8)
    end
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to request.referer, notice: "タグを追加しました"
    else
      @tags = Tag.all
      flash[:alert] = "必須項目を入力してください"
      render :index
    end
  end

  def update
    @tag = Tag.find(params[:id])
    @tag.update(tag_params)
    flash[:notice] = "変更を保存しました"
    redirect_back(fallback_location: root_path)
  end
  
  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    flash[:notice] = "タグを削除しました"
    redirect_back(fallback_location: root_path)
  end

  private

  def tag_params
    params.require(:tag).permit(:tag_name)
  end

end
