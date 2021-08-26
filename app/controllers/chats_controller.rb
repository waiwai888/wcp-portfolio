class ChatsController < ApplicationController

  def create
    chat = current_user.chats.new(chat_params)
    @room = chat.room
    chat.save
    chat.create_notification_dm!(current_user)
    @chats = @room.chats
    @chat = Chat.new(room_id: chat_params[:room_id])
  end

  def show
    chat = Chat.find(params[:id])
    room = chat.room
    user_rooms = room.user_rooms
    user_room = user_rooms.where.not(id: current_user.id).first
    @user = user_room.user
    # rooms = current_user.user_rooms.pluck(:room_id)
    # user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)

    # やりとりをしたことがある場合roomを抽出
    unless user_room.nil?
      @room = user_room.room
    # やりとりをしたことがない場合roomを新規作成
    else
      @room = Room.new
      @room.save
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
      UserRoom.create(user_id: @user.id, room_id: @room.id)
    end

    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)

  end

  private

    def chat_params
      params.require(:chat).permit(:message, :room_id)
    end

end
