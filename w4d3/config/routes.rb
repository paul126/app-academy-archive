Rails.application.routes.draw do

  resources :cats do
    resources :cat_rental_requests, only: :index
  end

  resources :cat_rental_requests, only: [:create, :new, :update] do

    post "approve", on: :member
    post "deny", on: :member

  end

  resources :users, only: [:create, :new]

  resources :sessions

  root to: redirect("/cats")

end
