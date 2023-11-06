require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :products
  resources :orders, only: [:new, :create, :show]

  devise_scope :user do
    authenticated :user do
      root to: 'orders#new', as: :authenticated_root
    end
    unauthenticated do
      root to: 'devise/sessions#new'
    end
  end
  authenticate :admin_user do
    mount Sidekiq::Web => '/sidekiq'
  end
end
