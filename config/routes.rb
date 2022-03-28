Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # TODO need admin to see this routes
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  root 'videos#index'

  resources :videos, only: %w[index show] do
    member do
      put :vote
    end
  end

  resources :users do
    member do
      get :share_movie
      post :share
      get :video
      get :subscribers
    end
  end
end
