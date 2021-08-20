class NotificationsController < ApplicationController

  def index
    @notifications = Notification.where(visited_id: current_user.id, checked: false).where.not(visiter_id: current_user.id).to_a
      # 通知の確認済みをtrueに変更して保存したいが、indexだとひとつの通知をどうピックアップすれば良いか。
      # ひとつ取り出せれば、それをupdate_attributesで確認済みに変更
    @notifications.each do |notification|
      notification.update_attributes(checked: true)
      @comment = PostComment.find_by(id: notification.comment_id)
    end
    @checked_notifications = Notification.where(visited_id: current_user.id, checked: true).where.not(visiter_id: current_user.id)
  end

  def destroy
  end

  def all_destroy
  @notifications = current_user.passive_notifications.destroy_all
  redirect_back(fallback_location: root_path)
  end

end
