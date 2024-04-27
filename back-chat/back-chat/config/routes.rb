Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'api/chat/list' => 'chats#list'
  post 'api/chat/connect/:user_id' => 'chats#connect'
  get 'api/chat/test' => 'chats#test'
end
