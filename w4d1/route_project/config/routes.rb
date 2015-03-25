RouteProject::Application.routes.draw do
  resources :users, only: [:index, :create, :show, :update, :destroy] do
    resources :contacts, only: :index
    resources :comments, only: :index

  end

  resources :contacts, only: [:create, :show, :update, :destroy] do
    resources :comments, only: :index

    member do
      patch 'favorite'
    end
  end

  resources :contact_shares, only: [:create, :destroy, :index] do
    resources :comments, only: :index

    member do
      patch 'favorite'
    end
  end

  resources :comments, only: :create

  resources :contact_groups, only: [:create, :destroy, :show]

  resources :group_memberships


end
