# frozen_string_literal: true

require 'sidekiq/web'
Rails.application.routes.draw do
  namespace :admins do
    get 'sessions/logout'
  end
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :admins
  devise_scope :admin do
    get '/admins/logout' => 'admins/sessions#logout'
  end
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    username == ENV['SIDEKIQ_ADMIN'] && password == ENV['SIDEKIQ_PASSWORD']
  end
  mount Sidekiq::Web => '/sidekiq'
  namespace :api do
    post :sign_in, to: 'sessions#create', as: :sign_in
    delete :sign_in, to: 'sessions#destroy', as: :sign_out
    resources :users, only: %i[create update]
    resources :events, only: %i[index show] do
      collection do
        post 'toggle_activation', to: 'events#toggle_activation'
      end
    end
  end

  # Defines the root path route ("/")
  root 'home#index'
end
