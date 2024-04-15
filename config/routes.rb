Rails.application.routes.draw do
  devise_for :users
  resources :tweets, only: [:index, :create, :update, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :users, only: [:show, :index] do
    member do
      post 'follow'
      delete 'unfollow'
    end
  end

  root 'tweets#index'
end
