ShoppingCart::Engine.routes.draw do
  root to: 'orders#edit'
  resources :orders, only: [:update, :create, :destroy]
  resources :order_items, only: [:destroy]
  resources :checkout
end
