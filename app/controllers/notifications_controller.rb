class NotificationsController < ApplicationController

  def index
    @notifications = Notification.where(visited_id: current_user.id, checked: false).to_a
      # 通知の確認済みをtrueに変更して保存したいが、indexだとひとつの通知をどうピックアップすれば良いか。
      # ひとつ取り出せれば、それをupdate_attributesで確認済みに変更
    @notifications.each do |notification|
      notification.update_attributes(checked: true)
      @comment = PostComment.find_by(id: notification.comment_id)
      # @time = time_ago_in_words(notification.created_at).upcase
    end
  end

  def destroy
  end

  def all_destroy
  end

end
