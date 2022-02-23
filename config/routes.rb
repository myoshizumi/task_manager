Rails.application.routes.draw do
  get 'sessions/new'
  root to: 'tasks#index'
  resources :tasks
  resources :sessions, only: %i[new create destroy]
  
  resources :users, only: %i[new create show edit update]
  namespace :admin do
    resources :users
  end
end
