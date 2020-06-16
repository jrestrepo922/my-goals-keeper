Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "welcome#home"

  resources :users, only: [:create]
  get 'signup', to: "users#new"


  delete "logout", to: "sessions#destroy", as: "logout"
  resources :sessions, only: [:create]
  get "signin", to: "sessions#new"

  # This for the admin to create or select a new genre
  # This also allows the admin to create a new game, edit game, delete game
  resources :genres, only: [:show, :new, :create] do 
    resources :products, only:[:new, :create, :edit, :update, :destroy, :index, :show]
  end

  #this is for the user that come to shop
  resources :genres, only: [:index]
  resources :wishlist, only: [:show, :delete]

  #omniauth 
  get '/auth/:provider/callback', to: 'sessions#create'
  
end
