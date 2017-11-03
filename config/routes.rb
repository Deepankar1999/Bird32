Rails.application.routes.draw do
  root to: 'tweets#index'
  resources :tweets
  resources :tags
end
