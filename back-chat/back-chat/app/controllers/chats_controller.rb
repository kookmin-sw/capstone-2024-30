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

  def poll
    @chat_room = ChatRoom.find_by(params[:chat_room_id])
    last_message_id = params[:last_message_id].to_i

    new message = []
  end

  def test
    test = @decoded[:uuid]

    test = User.find_by(user_id: "rqwerwerwer")

    render_success(data:test, message: "Hello World")
  end
end
