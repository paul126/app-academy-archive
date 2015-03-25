NewsReader::Application.routes.draw do
  namespace :api do
    resources :feeds, only: [:index, :create, :show, :destroy] do
      resources :entries, only: [:index]
    end

    resources :users, only: [:create, :index]
    resource :session, only: [:create, :destroy]
  end


  root to: "static_pages#index"
end
