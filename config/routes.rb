Rails.application.routes.draw do
  # ActionCable
  mount ActionCable.server => '/cable'
  resources :chatrooms, only: [:new, :create, :show]

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, only: :create do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  # Session routes
  get '/sign_in' => 'sessions#new', as: 'sign_in'
  delete '/sign_out' => 'sessions#destroy', as: 'sign_out'

  if Clearance.configuration.allow_sign_up?
    get '/sign_up' => 'users#new', as: 'sign_up'
  end

  # User routes
  get '/profile' => 'users#edit', as: 'profile'
  patch '/users' => 'users#update'
  post 'user/set_starred_chatrooms' => 'users#set_starred_chatrooms'

  # Chatroom routes
  get '/index' => 'chatrooms#index', as: 'home'
  get '/starred' => 'chatrooms#starred', as: 'starred'
  get '/chatrooms/:chatroom' =>'chatrooms#show', as: :chat_room_path
  post '/chatrooms/:chatroom' =>'chatrooms#show', as: :chat_room_send_path

  # Email confirmation
  get "/confirm_email/:token" => "email_confirmations#update", as: "confirm_email"

  # Root
  root 'sessions#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
