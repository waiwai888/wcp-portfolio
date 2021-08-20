module NotificationsHelper
    def notification_form(notification)
      @visiter = notification.visiter
      @comment = nil
      @chat = nil
      #notification.actionがfollowかlikeかcommentかdmか
      case notification.action
        when "follow" then
          tag.a(notification.visiter.nickname, href:user_path(@visiter), style:"font-weight: bold;")+"があなたをフォローしました"
        when "favorite" then
          tag.a(notification.visiter.nickname, href:user_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:post_path(notification.post_id), style:"font-weight: bold;")+"にいいねしました"
        when "comment" then
          @comment = PostComment.find_by(id: notification.comment_id)&.comment
          tag.a(@visiter.nickname, href:user_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:post_path(notification.post_id), style:"font-weight: bold;")+"にコメントしました"
        when "dm" then
          @chat = Chat.find_by(id: notification.chat_id)&.message
          tag.a(@visiter.nickname, href:user_path(@visiter), style:"font-weight: bold;")+"があなたに"+tag.a('メッセージ',href:chat_path(notification.chat_id), style:"font-weight: bold;")+"を送りました"
      end
    end
    def unchecked_notifications
      @notifications = current_user.passive_notifications.where(checked: false)
    end
end
