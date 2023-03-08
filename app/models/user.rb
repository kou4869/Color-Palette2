class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy

  # ↓ ActiveStorageでプロフィール画像を保存できるように設定
  has_one_attached :profile_image

  # ↓ プロフィール画像の設定
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'sample-author1.png'
  end



  with_options presence: true do
    validates :email
    validates :name
  end


end
