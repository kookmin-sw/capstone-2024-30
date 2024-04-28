# frozen_string_literal: true

class ChatsController < ApplicationController
  before_action :authorize_request
  def list
    user_id = @decoded[:uuid]

    user = User.find_by(user_id: user_id)
    unless user
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

    unless user1 or user2
      render_fail(message: "User not found", status: :bad_request)
      return
    end

    sorted_ids = [user1_id, user2_id].sort

    chat_room = ChatRoom.find_or_create_by(user1_uuid: sorted_ids[0], user2_uuid: sorted_ids[1])
    if chat_room.new_record?
      render_success(message: "Successfully chat room created", data: { chat_room_id: chat_room.id }, status: :created)
    else
      render_fail(message: "Chat room already exists", status: :bad_request)
    end
  end

  def join
    user_id = @decoded[:uuid]
    chat_room = ChatRoom.where('id = ? AND (user1_uuid = ? OR user2_uuid = ?)',
                               params[:chat_id], user_id, user_id).first

    unless chat_room
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
    else
      sorted_contents = message_contents.sort_by { |message| message[:id] }
      render_success(data: { messages: sorted_contents }, message: "Successfully message loaded")
    end
  end

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
            chat_room_id: chat_room_id,
            last_message_id: message.id,
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

  # 채팅방 하나에서 새 채팅을 계속 받아오는것
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
          timestamp: message.timestamp.strftime("%Y-%m-%d %H:%M")
        }
      end

      if new_messages.any?
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

  def send_message
    user_id = @decoded[:uuid]

    chat_room = ChatRoom.where('id = ? AND (user1_uuid = ? OR user2_uuid = ?)',
                               params[:chat_id], user_id, user_id).first

    unless chat_room
      render_fail(message: "Chat room not found", status: :bad_request)
    end

    content = params[:content]
    message = chat_room.messages.create(user_id: user_id, content: content)

    if message.persisted?
      render_success(data: message, message: "Message sent", status: :created)
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
