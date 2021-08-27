class AddRoomIdToNotifications < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :chat_id, :integer
    add_column :notifications, :room_id, :integer
  end
end
