$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "shopping_cart/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "shopping-cart"
  s.version     = ShoppingCart::VERSION
  s.authors     = ["Kirill Oleynik"]
  s.email       = ["kirill.olejnik@gmail.com"]
  s.homepage    = "https://github.com/kirill-oleynik/ShoppingCart"
  s.summary     = "Shopping cart & checkout functionality"
  s.description = "ShoppingCart plugin provides checkout functionality, which can be integrated into your online store and configured according to your business logic."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 5.0.0", ">= 5.0.0.1"
  s.add_dependency 'pg'
  s.add_dependency 'aasm'
  s.add_dependency 'haml'
  s.add_dependency 'rectify'
  s.add_dependency 'drape'
  s.add_dependency 'wicked'
  s.add_dependency 'devise'
  s.add_dependency 'simple_form'
  s.add_dependency 'country_select'
  s.add_dependency 'credit_card_validations'
  s.add_dependency 'bootstrap-sass'
  s.add_dependency 'rails-controller-testing'
  s.add_dependency 'ffaker'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'coffee-rails'
  s.add_dependency 'database_cleaner'

  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'shoulda-matchers'
end
