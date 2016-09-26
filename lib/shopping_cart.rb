require "shopping_cart/engine"
require 'haml'
require 'rectify'
require 'drape'
require 'wicked'
require 'simple_form'
require 'country_select'
require 'credit_card_validations'
require 'bootstrap-sass'
require 'rails-controller-testing'
require 'devise'
require 'ffaker'
require 'database_cleaner'
require 'jquery-rails'

module ShoppingCart
  mattr_accessor :user_class
  mattr_accessor :checkout_steps
end
