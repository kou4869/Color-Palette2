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

  validates :name,           presence: true, length: { minimum: 2, maximum: 10, message: "は2文字以上、10文字以内で入力してください" }
  validates :introduction,   length: { maximum: 50, message: "は50文字以内で入力してください" }


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

  def Post.user_posts(sort, page, per)
    sort = sort.blank? ? "latest" : sort
     #並び替えとタグ検索を同時に行うための記述
    case sort
    when "latest"
      results = Post.order(created_at: :desc)
    when "oldest"
      results = Post.order(created_at: :asc)
    when "avarage_star"
      results = Post.sort_by { |a| a.avarage_star }.reverse
    end
    results = Kaminari.paginate_array(results).page(page).per(per)
    return results
  end




end
