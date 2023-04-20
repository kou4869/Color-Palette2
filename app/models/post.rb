class Post < ApplicationRecord
  belongs_to :user

  has_many :post_tags,      dependent: :destroy  # Postsテーブルからpost_tags（中間テーブル）に対する関連付け
  has_many :tags,           through: :post_tags       # post_tags（中間テーブル）を介してPostsテーブルへの関連付け
  has_many :comments,       dependent: :destroy
  has_many :favorites,      dependent: :destroy

  validates :color1, :color2, :color3, :color4,   presence: true
  validates :post_introduction,                   length: { maximum: 300, message: "配色の説明は300文字以内で入力してください" }
  # 投稿された4色の色がすでに同じパターンで投稿されていた場合、投稿ができないようにする
  validates :color1, uniqueness: { scope: [:color2, :color3, :color4], message: "この配色はすでに登録が存在します" }

  # エラーのメッセージで『color1』と『post_introduction』表示させないようにしている
  HUMANIZED_ATTRIBUTES = {
    :color1 => "",
    :post_introduction => ""#
  }

  def self.human_attribute_name(attr, options={})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end

  #ブックマーク機能用の定義
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  # def index(sort, page, per)
  #   sort = sort.blank? ? "latest" : sort
  #       #並び替えとタグ検索を同時に行うための記述
  #   case sort
  #   when "latest"
  #     results = self.order(created_at: :desc)
  #   when "oldest"
  #     results = self.order(created_at: :asc)
  #   when "avarage_star"
  #     results = self.sort_by { |a| a.avarage_star }.reverse
  #   end
  #   results = Kaminari.paginate_array(results).page(page).per(per)
  #   return results
  # end

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
