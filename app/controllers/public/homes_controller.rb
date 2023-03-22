class Public::HomesController < ApplicationController
  def top
    @posts = Post.all.order(created_at: "DESC")
  end
end
