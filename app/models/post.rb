class Post < ApplicationRecord
    belongs_to :user
    
    has_many :post_tags, dependent: :destroy  # Postsテーブルからpost_tags（中間テーブル）に対する関連付け
    has_many :tags, through: :post_tags       # post_tags（中間テーブル）を介してPostsテーブルへの関連付け
end
