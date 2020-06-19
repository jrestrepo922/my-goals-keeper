Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "welcome#home"

  resources :users, only: [:create]
  get 'signup', to: "users#new"


  delete "logout", to: "sessions#destroy", as: "logout"
  resources :sessions, only: [:create]
  get "signin", to: "sessions#new"


  #nested routes
  resources :categories, only: [:index, :destroy] do 
    resources :goals, only: [:new, :create, :edit, :update, :index, :show]
  end 

  #new and index require 2 views for each 
    #one is for the nested routes and the other ones for not nested

  resources :goals, only: [:new, :create, :index]
  
 

  #omniauth 
  get '/auth/:provider/callback', to: 'sessions#create'
  
end
