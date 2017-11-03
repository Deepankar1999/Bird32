Rails.application.routes.draw do
  devise_for :users
  root to: 'tweets#index'
  resources :tweets, only: [:index, :create, :destroy]
  resources :tags, only: [:index, :show]
end
