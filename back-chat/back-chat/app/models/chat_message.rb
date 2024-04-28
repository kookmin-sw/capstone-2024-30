class ChatMessage < ApplicationRecord
  belongs_to :chat_room
  before_save :set_local_timestamp

  def set_local_timestamp
    self.timestamp = Time.current
  end
end