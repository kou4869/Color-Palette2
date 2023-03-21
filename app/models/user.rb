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

  validates :name,           presence: true, length: { minimum: 2, maximum: 20, message: "は2文字以上、20文字以内で入力してください" }
  validates :introduction,   length: { maximum: 50, message: "は50文字以内で入力してください"}


  # admin側でソート機能を使用するためのscope
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  

  # ↓ プロフィール画像の設定
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'sample-author1.png'
  end

  # ↓ ゲストログイン用の設定
  def self.guest
    find_or_create_by!(name: 'guestuser' ,email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end

end
