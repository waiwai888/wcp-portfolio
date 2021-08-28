class ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :follow_each_other, only: [:show]

  def create
    @chat = current_user.chats.new(chat_params)
    @room = @chat.room
    @chat.save
    @chat.room.create_notification_dm!(current_user, @chat.room_id, @chat.id)
    @chats = @room.chats
    @chat = Chat.new(room_id: chat_params[:room_id])
  end

  def show
    @user = User.find(params[:id])
    rooms = current_user.user_rooms.pluck(:room_id)
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)

    unless user_rooms.nil?
      @room = user_rooms.room
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

    def follow_each_other
      if params[:id] == nil
        redirect_to user_path(current_user)
      end
      @user = User.find(params[:id])

      if current_user.following?(@user) == false || @user.following?(current_user) == false
        redirect_to user_path(current_user)
      end
    end

end
