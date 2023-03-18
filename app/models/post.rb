class Post < ApplicationRecord
  belongs_to :user

  has_many :post_tags,      dependent: :destroy  # Postsテーブルからpost_tags（中間テーブル）に対する関連付け
  has_many :tags,           through: :post_tags       # post_tags（中間テーブル）を介してPostsテーブルへの関連付け
  has_many :comments,       dependent: :destroy
  has_many :favorites,      dependent: :destroy


  #ブックマーク機能用の定義
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  #raty.jsを使用した総合評価のための定義
  def avarage_star
    reviews_arry = comments.where(parent_id: nil).pluck(:star)  #コメントが『parent_id: nil』だった時(Postに対するコメントだった時)、コメントに付属されているstarカラムの値を取得
    total_count = reviews_arry.count  #star付の投稿の個数を集計
    return 0 if total_count.zero?     #トータルのカウントがゼロだった(またはコメントがなかった)時、リターンで『０』を返す
    total_review_count = reviews_arry.sum  #star付の投稿の星の数を集計
    total_review_count / total_count  #18行目の星の数の合計 ÷ 16行目の投稿の個数を行い、星の平均値を出している
  end

  #投稿の並び替え
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(create_at: :asc)}


end
