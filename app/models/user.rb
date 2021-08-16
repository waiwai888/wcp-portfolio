class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image

  has_many :favorites, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :user_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  #通知機能
  # 自分が通知を作った場合→foreign_keyにvisiter_id(自分のuser.id)を指定し、active_notificationsモデル（実態はnotificationモデル）へアクセスする
  has_many :active_notifications, class_name: "Notification", foreign_key: "visiter_id", dependent: :destroy
  # 自分宛の通知の場合→foreign_keyにvisited_id(自分のuser.id)を指定し、passive_notificationsモデル（実態はnotificationモデル）へアクセスする
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy

  #フォロー機能
  # 自分をフォローしているユーザーを探す→forign_keyにfollowed_id（自分のuser.id）を指定して探す
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # reverse_of_relationshipsを通じて、自分をフォローしている人たち（followers）を抽出
  has_many :followers, through: :reverse_of_relationships, source: :follower
  # 自分がフォローしているユーザーを探す→foreign_keyにfollower_id（自分のuser.id）を指定して探す
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # relationshipsを通じて、自分がフォローしている人たち（followings）を抽出
  has_many :followings, through: :relationships, source: :followed

  validates :name, presence: true, uniqueness: true
  validates :account_name, presence: true, uniqueness: true
  validates :nickname, presence: true
  validates :account_name, length: { minimum: 6 }

  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

  def create_notification_follow!(current_user)
    follow_exist = Notification.where(["visiter_id = ? and visited_id = ? and action = ? ", current_user.id, id, 'follow'])
    if follow_exist.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow',
        checked: false
        )
        notification.save if notification.valid?
    end
  end
  
end