ShoppingCart::Engine.routes.draw do
  get '/', to: 'orders#edit'
  resources :orders, only: [:update, :create, :destroy]
  resources :order_items, only: [:destroy]
  resources :checkout
end
