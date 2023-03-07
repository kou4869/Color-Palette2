class Tag < ApplicationRecord
    
    has_many :post_tags, dependent: :destroy, foreign_key: 'tag_id'    # Tagsテーブルからpost_tags（中間テーブル）に対する関連付け
    has_many :posts, through: :post_tags                               # post_tags（中間テーブル）を介してPostsテーブルへの関連付け

    validates :tag_name, uniqueness: true, presence: true
    # uniqueness: trueはuniquenessはオブジェクトが保存される直前に、属性の値が一意であり重複していないことを検証する。

end
