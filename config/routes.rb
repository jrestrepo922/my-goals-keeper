Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "welcome#home"

  resources :users, only: [:create]
  get 'signup', to: "users#new"


  delete "logout", to: "sessions#destroy", as: "logout"
  resources :sessions, only: [:create]
  get "signin", to: "sessions#new"



  #omniauth 
  get '/auth/:provider/callback', to: 'sessions#create'
  
end
