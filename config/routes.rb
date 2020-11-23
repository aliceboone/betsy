# frozen_string_literal: true
Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'homepages#homepage'
  resources :homepages, only: [:index]

  resources :products do
    resources :order_items, only: [:create, :destroy]
    resources :reviews, only: [:new]
  end

  get '/auth/github', as: 'github_login'
  get '/auth/github/callback', to: 'merchants#create', as: 'create_merchant'
  delete '/logout', to: 'merchants#destroy', as: 'logout'

  resources :products
  resources :merchants
  get '/profile', to: 'merchants#profile', as: 'profile'

  resources :order_items, only: %i[update destroy]
  patch 'order_items/:id/mark_shipped', to: 'order_items#mark_shipped', as: 'mark_shipped'

  get '/orders/cart', to: 'orders#cart', as: 'cart'

  resources :orders, only: %i[index show edit update]

  get '/orders/:id/cart/success', to: 'orders#success', as: 'success'
  patch '/orders/:id/cancel', to: 'orders#cancel', as: 'cancel'

  resources :reviews, only: [:create, :update]
  resources :categories
  resources :order_items
  resources :categories
end
