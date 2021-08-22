class NotificationsController < ApplicationController

  def index
    @notifications = Notification.where(visited_id: current_user.id, checked: false).where.not(visiter_id: current_user.id).to_a
      # 通知の確認済みをtrueに変更して保存したいため、.to_aで配列とし、その後checked: trueにすることで表示を可能に。
    @notifications.each do |notification|
      notification.update_attributes(checked: true)
      @comment = PostComment.find_by(id: notification.comment_id)
    end
    @checked_notifications = Notification.where(visited_id: current_user.id, checked: true).where.not(visiter_id: current_user.id)
  end

  def destroy
    notification = Notification.find(params[:id])
    notification.destroy
    redirect_back(fallback_location: root_path)
  end

  def destroy_all
    @checked_notifications = Notification.where(visited_id: current_user.id, checked: true).where.not(visiter_id: current_user.id)
    @checked_notifications.destroy_all
    redirect_back(fallback_location: root_path)
  end

end
