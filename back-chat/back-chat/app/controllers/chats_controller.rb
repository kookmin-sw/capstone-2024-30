# frozen_string_literal: true

class ChatsController < ApplicationController
  before_action :authorize_request
  def list
    user_id = @decoded[:uuid]

    user = User.find_by(user_id: user1_id)
    unless user
      render_fail(message: "User not found", status: :bad_request)
      return
    end

    chat_rooms = ChatRoom.where("user1_uuid = ? OR user2_uuid = ?", user_id, user_id)

    render_success(data: chat_rooms, message: "Chat rooms retrieved successfully")
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
        content: message.content,
        timestamp: message.timestamp.strftime("%Y-%m-%d %H:%M")
      }
    end

    if message_contents.empty?
      render_fail(message: "No message to load", status: :bad_request)
    else
      render_success(data: { messages: message_contents }, message: "Successfully message loaded")
    end
  end

  # Long Polling
  def poll
    user_id = @decoded[:uuid]
    chat_room = ChatRoom.where('chat_room_id = ? AND (user1_uuid = ? OR user2_uuid = ?)',
                               params[:chat_id], user_id, user_id).first

    unless chat_room
      render_fail(message: "Chat room not found", status: :bad_request)
    end

    last_message_id = params[:chat_message_id].to_i
    timeout = 20.seconds.from_now

    loop do
      new_messages = ChatMessage
                       .where('chat_room_id = ? AND id > ? AND user_id != ?', chat_room.id, last_message_id, user_id)
                       .order(timestamp: :desc)
                       .limit(100)
                       .map do |message|
        {
          content: message.content,
          timestamp: message.timestamp.strftime("%Y-%m-%d %H:%M")
        }
      end

      if new_messages.any?
        render_success(message: "Polling Successful", data: { messages: new_messages })
      elsif Time.current >= timeout
        render_fail(message: "Chat room timeout", status: :bad_request)
      else
        sleep(5)
      end
    end
  end


  def test
    test = @decoded[:uuid]

    test = User.find_by(user_id: "rqwerwerwer")

    render_success(data:test, message: "Hello World")
  end
end
