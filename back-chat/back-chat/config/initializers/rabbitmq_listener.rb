# 메시지 리스너 설정 예시
require 'bunny'

Thread.new do
  begin
    connection = Bunny.new(hostname: 'localhost', automatically_recover: false)
    connection.start
    channel = connection.create_channel
    queue = channel.queue('chat_messages')

    queue.subscribe(block: true) do |delivery_info, properties, body|
      ActiveRecord::Base.connection_pool.with_connection do
        chat_room_id, message_content = parse_message(body)
        chat_room = ChatRoom.find(chat_room_id)
        chat_room.messages.create(content: message_content)
      end
    end
  rescue StandardError => e
    Rails.logger.error "RabbitMQ Listener Error: #{e.message}"
  ensure
    connection.close if connection && connection.open?
  end
end