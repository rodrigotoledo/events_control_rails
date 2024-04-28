# frozen_string_literal: true

require "sidekiq/web"
Rails.application.routes.draw do
  namespace :users do
    get "sessions/logout"
  end
  mount RailsAdmin::Engine => "/admin", as: "rails_admin"
  devise_for :users
  devise_scope :user do
    get "/users/logout" => "users/sessions#logout"
  end
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    username == ENV["SIDEKIQ_ADMIN"] && password == ENV["SIDEKIQ_PASSWORD"]
  end
  mount Sidekiq::Web => "/sidekiq"
  namespace :api do
    post :sign_in, to: "sessions#create", as: :sign_in
    delete :sign_in, to: "sessions#destroy", as: :sign_out
    resources :participants, only: %i[create update]
    resources :events, only: :index do
      collection do
        post "toggle_activation", to: "events#toggle_activation"
      end
    end
  end

  # Defines the root path route ("/")
  root "home#index"
end
