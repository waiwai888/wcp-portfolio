class Post < ApplicationRecord

  attachment :image

  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  belongs_to :user

  #タグ機能
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

	validates :body, presence: true

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
  def create_notification_favorite!(current_user)
    # いいねされているか検索
    favorite_exist = Notification.where("visitor_id = ? and visited_id = ? and post_id = ? action = ? ", current_user.id, user.id, id, 'favorite')
    # いいねされている場合は通知を作成
    if favorite_exist.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: 'favorite'
        )
    end
    # いいねした人、された人が同一の場合、通知は確認済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked == true
    end
    
    notification.save if notification.valid?
  end
  
  def create_notification_comment!(current_user, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    comment_users = PostComment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    comment_users.each do |comment_user|
      save_notification_comment!(current_user, comment_id, comment_user['user_id']) if comment_users.blank?
    end
      # まだ誰もコメントしていない場合は、投稿者に通知を送る
      save_notification_comment!(current_user, comment_id, user_id) if comment_users.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    # 複数回のコメントを考慮。１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visiter_id == notification.visited_id
      notification.checked = true
    end
    notification.save! if notification.valid?
  end
  
  

end
