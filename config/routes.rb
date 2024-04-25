Rails.application.routes.draw do
  namespace :users do
    get 'sessions/logout'
  end
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  devise_scope :user do
    get "/users/logout" => "users/sessions#logout"
  end

  # Defines the root path route ("/")
  root "home#index"
end
