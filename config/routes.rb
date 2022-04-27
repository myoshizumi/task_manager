# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'users#new'
  resources :tasks
  resources :sessions, only: %i[new create destroy]
  
  resources :users, only: %i[new create show edit update]
  namespace :admin do
    resources :users
  end
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # get '*not_found', to: 'application#routing_error'
end
