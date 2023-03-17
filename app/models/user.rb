class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts,          dependent: :destroy
  has_many :comments,       dependent: :destroy
  has_many :favorites,      dependent: :destroy

  # ↓ ActiveStorageでプロフィール画像を保存できるように設定
  has_one_attached :profile_image

  validates :name,           presence: true, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction,   presence: true, length: { maximum: 50}

  

  # ↓ プロフィール画像の設定
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'sample-author1.png'
  end


end
