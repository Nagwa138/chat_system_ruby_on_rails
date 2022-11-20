Rails.application.routes.draw do
  # resources :chat_resources
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "applications#index"

  # get "applications/:application_token/chats", to: "chats#index"

  resources :applications do
    resources :chats do
      resources :messages
    end
  end

end
