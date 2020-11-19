Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "homepages#homepage"
  resources :homepages, only: [:index]

  resources :products do
    resources :orderitems, only: [:create]
  end

  get "/auth/github", as: "github_login"
  get "/auth/github/callback", to: "merchants#create", as: "create_merchant"
  delete "/logout", to: "users#destroy", as: "logout"

  resources :products

  resources :merchants

  resources :orderitems, only: [:update, :destroy]
  patch 'orderitems/:id/mark_shipped', to: 'orderitems#mark_shipped', as: 'mark_shipped'

  resources :orders, only: [:index, :show, :edit, :update]
  get '/orders/:id/cart/success', to: 'orders#success', as: 'success'
  get '/orders/:id/cart', to: 'orders#cart', as: 'cart'
  patch '/orders/:id/cancel', to: 'orders#cancel', as: 'cancel'

  resources :reviews, only: [:new, :create]
  resources :categories, only: [:new, :create, :show]
end
