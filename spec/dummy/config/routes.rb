Rails.application.routes.draw do
  mount ShoppingCart::Engine => "/cart"
end
