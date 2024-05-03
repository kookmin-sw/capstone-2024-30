class ChatsPollingController < ApplicationController
  include ActionController::Live

  before_action :authorize_request

  def room_poll
    user_id = @decoded[:uuid]
    last_room_id = params[:room_id].to_i

    timeout = 10.seconds.from_now

    loop do
      new_rooms = ChatRoom
                    .where("id > ? AND (user1_uuid = ? OR user2_uuid = ?)", last_room_id, user_id, user_id)

      print new_rooms.ids

      new_rooms_data = new_rooms.map do |chat_room|
        other_user_id = chat_room.user1_uuid == user_id ? chat_room.user2_uuid : chat_room.user1_uuid
        last_message = chat_room.messages.order(timestamp: :desc).first

        {
          chat_room_id: chat_room.id,
          user_id: other_user_id,
          user_name: User.find_by(user_id: other_user_id)&.name,
          last_message_id: last_message ? last_message.id : 0,
          chat_room_message: last_message ? last_message.content : "",
          chat_room_date: last_message ? last_message.timestamp.strftime("%Y-%m-%d %H:%M") : "2000-06-04 00:00"
        }
      end

      if new_rooms_data.any?
        sorted_contents = new_rooms_data.sort_by { |message| message[:id] }
        render_success(message: "Polling Successful", data: { rooms: sorted_contents })
        return
      elsif Time.current >= timeout
        render_fail(message: "Chat room timeout", status: :bad_request)
        return
      else
        sleep(2)
      end

    end
  end

  def message_poll
    user_id = @decoded[:uuid]

    chat_room_list = params.require(:list)

    updated_rooms = []
    timeout = 10.seconds.from_now

    loop do
      chat_room_list.each do |room|
        chat_room_id = room[:id].to_i
        last_message_id = room[:message_id].to_i

        new_message = ChatMessage
                        .includes(:user)
                        .where('chat_room_id = ? AND id > ? AND user_id != ?', chat_room_id, last_message_id, user_id)
                        .order(timestamp: :desc)
                        .limit(1)
                        .map do |message|
          {
            id: message.id,
            chat_room_id: chat_room_id,
            content: message.content,
            user_id: message.user_id,
            user_name: message.user.name,
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
        render_fail(message: "Chat Message List timeout", status: :bad_request)
        return
      else
        sleep(2)
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
    timeout = 10.seconds.from_now

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
        sleep(2)
      end
    end
  end
end
