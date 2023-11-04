Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'orders#new'
  resources :products
  resources :orders, only: [:new, :create, :show]
end
