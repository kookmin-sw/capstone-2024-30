Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'api/chat/list' => 'chats#list'
  get 'api/chat/join/:chat_id/:message_id' => 'chats#join'
  get 'api/chat/test' => 'chats#test'
end
