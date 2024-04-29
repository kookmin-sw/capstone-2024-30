Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'api/chat/list' => 'chats#list'
  get 'api/chat/join/:chat_id/:message_id' => 'chats#join'
  post 'api/chat/connect/:user_id' => 'chats#connect'
  post 'api/chat/poll/list' => 'chats_polling#short_poll'
  post 'api/chat/poll/:chat_id/:message_id' => 'chats_polling#detail_poll'
  post 'api/chat/:chat_id' => 'chats#send_message'
  get 'api/chat/test' => 'chats#test'
end
