Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show]
  resources :events, only: [:index, :new, :create, :show]

  resources :user_sessions, only: [:new, :create, :destroy]

  root 'events#index'
end
