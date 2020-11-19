Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "homepages#homepage"

  get "/auth/github", as: "github_login"
  get "/auth/github/callback", to: "merchants#create", as: "create_merchant"
  delete "/logout", to: "users#destroy", as: "logout"

  resources :products
  resources :merchants
  resources :order_items
  resources :orders
end
