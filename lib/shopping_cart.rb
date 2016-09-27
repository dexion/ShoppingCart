require_relative 'shopping_cart/configuration'
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

  class << self
    attr_accessor :config
  end

  def self.configure
    self.config ||= Configuration.new
    yield(config)
  end
end
