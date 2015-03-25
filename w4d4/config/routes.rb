Rails.application.routes.draw do

  resources :users, only: [:create, :new, :show]
  resource :sessions, only: [:create, :new, :destroy]

  resources :bands
  resources :albums
  resources :tracks, except: :index

  resources :notes, only: [:new, :create, :destroy]

end
