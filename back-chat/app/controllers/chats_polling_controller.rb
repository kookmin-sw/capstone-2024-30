class ChatsPollingController < ApplicationController
  include ActionController::Live

  before_action :authorize_request

  def short_poll
    user_id = @decoded[:uuid]

    chat_room_list = params.require(:list)

    updated_rooms = []
    timeout = 20.seconds.from_now

    loop do
      chat_room_list.each do |room|
        chat_room_id = room[:id].to_i
        last_message_id = room[:message_id].to_i

        new_message = ChatMessage
                        .where('chat_room_id = ? AND id > ? AND user_id != ?', chat_room_id, last_message_id, user_id)
                        .order(timestamp: :desc)
                        .limit(1)
                        .map do |message|
          {
            id: message.id,
            chat_room_id: chat_room_id,
            content: message.content,
            timestamp: message.timestamp.strftime("%Y-%m-%d %H:%M")
          }
        end

        updated_rooms.concat(new_message)
      end

      if updated_rooms.any?
        sorted_contents = updated_rooms.sort_by { |message| message[:id] }
        render_success(message: "Polling Successful", data: { messages: sorted_contents })
        return
      elsif Time.current >= timeout
        render_fail(message: "Chat room timeout", status: :bad_request)
        return
      else
        sleep(5)
      end

    end
  end
  def detail_poll
    user_id = @decoded[:uuid]
    chat_room = ChatRoom.where('id = ? AND (user1_uuid = ? OR user2_uuid = ?)',
                               params[:chat_id], user_id, user_id).first

    unless chat_room
      render_fail(message: "Chat room not found", status: :bad_request)
    end

    last_message_id = params[:message_id].to_i
    timeout = 20.seconds.from_now

    loop do
      new_messages = ChatMessage
                       .where('chat_room_id = ? AND id > ? AND user_id != ?', chat_room.id, last_message_id, user_id)
                       .order(timestamp: :desc)
                       .limit(100)
                       .map do |message|
        {
          id: message.id,
          content: message.content,
          user_id: message.user_id,
          timestamp: message.timestamp.strftime("%Y-%m-%d %H:%M")
        }
      end

      if !new_messages.empty?
        sorted_contents = new_messages.sort_by { |message| message[:id] }
        render_success(message: "Polling Successful", data: { messages: sorted_contents })
        return
      elsif Time.current >= timeout
        render_fail(message: "Chat room timeout", status: :bad_request)
        return
      else
        sleep(5)
      end
    end
  end
end
