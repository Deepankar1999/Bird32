Rails.application.routes.draw do
  root to: 'tweets#index'
  resources :tweets, only: [:index, :create, :destroy]
  resources :tags, only: [:index, :show]
end
