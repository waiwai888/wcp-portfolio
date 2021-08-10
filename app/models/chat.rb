class Chat < ApplicationRecord

  belongs_to :user
  belongs_to :room
  has_many :notifications, dependent: :destroy

  def create_notification_dm!(current_user, chat)
    room = chat.room
    chat_user = UserRoom.where(room_id: room.id).where.not(user_id: current_user.id).pluck('user_id')
    #同じUserRoomに属する自分以外のユーザーid（つまり相手のユーザーid）を抽出
    notification = current_user.active_notifications.new(
      chat_id: chat.id,
      visited_id: chat_user.first,
      visiter_id: current_user.id,
      action: 'dm',
      checked: false
    )
      # 自分の投稿に対するコメントの場合は、通知済みとする
      if notification.visiter_id == notification.visited_id
          notification.checked = true
      end
      notification.save if notification.valid?
      #redirect_back(fallback_location: root_path)
  end

end
