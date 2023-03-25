class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # parentは返信対象となるコメントのID
  belongs_to :parent,  class_name: "Comment", optional: true
  # repliesは返信されたコメント
  has_many   :replies, class_name: "Comment", foreign_key: :parent_id, dependent: :destroy

  validates :comment, length: { maximum: 150 }

  # postの詳細ページで子コメントのみの表示をしないためのscope
  scope :children, -> { where.not(parent_id: nil) }
  scope :parents, -> { where(parent_id: nil) }

  # admin側でソート機能を使用するためのscope
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}

end
