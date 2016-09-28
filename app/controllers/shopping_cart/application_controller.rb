module ShoppingCart
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    before_action "authenticate_#{ShoppingCart.config.user_class.downcase}!".to_sym

    alias_method :current_user, "current_#{ShoppingCart.config.user_class.downcase}".to_sym
  end
end
