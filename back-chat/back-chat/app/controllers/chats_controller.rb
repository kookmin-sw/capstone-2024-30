# frozen_string_literal: true

class ChatsController < ApplicationController
  before_action :authorize_request
  def list
    user_id = @decoded[:uuid]

    user = User.find_by(user_id: user_id)
    if user.nil?
      render_fail(message: "User not found", status: :bad_request)
      return
    end

    chat_rooms = ChatRoom.where("user1_uuid = ? OR user2_uuid = ?", user_id, user_id).includes(:messages)

    other_user_ids = chat_rooms.map do |room|
      room.user1_uuid == user_id ? room.user2_uuid : room.user1_uuid
    end.uniq

    users_info = User.where(user_id: other_user_ids).index_by(&:user_id)

    chat_rooms_data = chat_rooms.map do |chat_room|
      other_user_id = chat_room.user1_uuid == user_id ? chat_room.user2_uuid : chat_room.user1_uuid
      last_message = chat_room.messages.order(timestamp: :desc).first
      {
        chat_room_id: chat_room.id,
        user_id: other_user_id,
        user_name: users_info[other_user_id]&.name,
        last_message_id: last_message&.id,
        chat_room_message: last_message&.content,
        chat_room_date: last_message&.timestamp&.strftime("%Y-%m-%d %H:%M")
      }
    end

    sorted_rooms = chat_rooms_data.sort_by { |room| room[:chat_room_date] ? DateTime.parse(room[:chat_room_date]) : DateTime.new(0) }.reverse

    render_success(data: { rooms: sorted_rooms }, message: "Chat rooms retrieved successfully")
  end

  # 유저간 채팅방을 생성해줌
  def connect
    user1_id = params[:user_id]
    user2_id = @decoded[:uuid]

    user1 = User.find_by(user_id: user1_id)
    user2 = User.find_by(user_id: user2_id)

    if user1.nil? || user2.nil?
      render_fail(message: "User not found", status: :bad_request)
      return
    end

    sorted_ids = [user1_id, user2_id].sort

    chat_room = ChatRoom.find_by(user1_uuid: sorted_ids[0], user2_uuid: sorted_ids[1])
    if chat_room.nil?
      chat_room = ChatRoom.create(user1_uuid: sorted_ids[0], user2_uuid: sorted_ids[1])
      render_success(message: "Successfully chat room created", data: { chat_room_id: chat_room.id }, status: :created)
    else
      render_fail(message: "Chat room already exists", status: :bad_request)
    end
  end

  def join
    user_id = @decoded[:uuid]
    chat_room = ChatRoom.where('id = ? AND (user1_uuid = ? OR user2_uuid = ?)',
                               params[:chat_id], user_id, user_id).first

    if chat_room.nil?
      render_fail(message: "Chat room not found", status: :bad_request)
    end

    last_message_id = params[:message_id].to_i

    message_contents = ChatMessage
                         .where('chat_room_id = ? AND id > ? AND user_id != ?',
                                params[:chat_id], last_message_id, user_id)
                         .order(timestamp: :desc)
                         .limit(100)
                         .map do |message|
      {
        id: message.id,
        content: message.content,
        timestamp: message.timestamp.strftime("%Y-%m-%d %H:%M")
      }
    end

    if message_contents.empty?
      render_fail(message: "No message to load", status: :bad_request)
      return
    else
      sorted_contents = message_contents.sort_by { |message| message[:id] }
      render_success(data: { messages: sorted_contents }, message: "Successfully message loaded")
      return
    end
  end

  def send_message
    user_id = @decoded[:uuid]

    chat_room = ChatRoom.where('id = ? AND (user1_uuid = ? OR user2_uuid = ?)',
                               params[:chat_id], user_id, user_id).first

    if chat_room.nil?
      render_fail(message: "Chat room not found", status: :bad_request)
    end

    content = params[:content]
    message = chat_room.messages.create(user_id: user_id, content: content)
    response = {
      id: message.id,
      content: message.content,
      timestamp: message.timestamp.strftime("%Y-%m-%d %H:%M")
    }

    print(response)

    if message.persisted?
      render_success(data: response, message: "Message sent", status: :created)
      return
    end
    render_fail(message: "Message Send Error", status: :bad_request)
  end

  def test
    test = @decoded[:uuid]

    test = User.find_by(user_id: "rqwerwerwer")

    render_success(data:test, message: "Hello World")
  end
end
