Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show]
  resources :events, only: [:index, :new, :create, :show] do
    member do
      patch :attend
    end
  end

  resources :user_sessions, only: [:new, :create, :destroy]

  root 'events#index'
end
