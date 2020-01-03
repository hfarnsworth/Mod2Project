Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :missions
  resources :teams
  resources :superheros
  resources :users, only: [:show, :new, :create]
  resources :sessions, only: [:new, :create]
  delete '/session', to: 'sessions#destroy', as: 'logout'
  get '/sessions/new', to: 'sessions#new', as: 'login'
  root 'pages#main'
  get 'pages/options', to: 'pages#options', as: 'options'
end