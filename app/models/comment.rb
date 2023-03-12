class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # parentは返信対象となるコメントのID
  belongs_to :parent,  class_name: "Comment", optional: true
  # repliesは返信されたコメント
  has_many   :replies, class_name: "Comment", foreign_key: :parent_id, dependent: :destroy

  validates :comment, presence:true, length: { maximum: 300 }
end
