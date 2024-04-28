class ChatRoom < ApplicationRecord
  has_many :messages, class_name: 'ChatMessage', foreign_key: 'chat_room_id', dependent: :destroy
end
