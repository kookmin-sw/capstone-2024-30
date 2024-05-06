class ChatMessage < ApplicationRecord
  belongs_to :chat_room
  belongs_to :user, primary_key: "user_id", foreign_key: "user_id"
  before_save :set_local_timestamp

  def set_local_timestamp
    self.timestamp = Time.current
  end
end