Rails.application.routes.draw do
  get 'api/chat/list' => 'chats#list'
  get 'api/chat/join/:chat_id/:message_id' => 'chats#join'
  post 'api/chat/connect/:user_id' => 'chats#connect'
  post 'api/chat/poll/room/:room_id' => 'chats_polling#room_poll'
  post 'api/chat/poll/message' => 'chats_polling#message_poll'
  post 'api/chat/poll/:chat_id/:message_id' => 'chats_polling#detail_poll'
  post 'api/chat/:chat_id' => 'chats#send_message'
end
