require "shopping_cart/engine"
require 'haml'
require 'rectify'
require 'drape'
require 'wicked'
require 'simple_form'
require 'country_select'

module ShoppingCart
  mattr_accessor :user_class
end
