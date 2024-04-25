Rails.application.routes.draw do
  namespace :users do
    get 'sessions/logout'
  end
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  devise_scope :user do
    get "/users/logout" => "users/sessions#logout"
  end

  namespace :api do
    resources :events, only: :index do
      member do
        post 'add_participant', to: 'events#add_participant'
        delete 'remove_participant', to: 'events#remove_participant'
      end
    end
  end

  # Defines the root path route ("/")
  root "home#index"
end
