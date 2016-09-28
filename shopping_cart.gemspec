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
  s.add_dependency 'pg', '~> 0.19.0'
  s.add_dependency 'aasm', '~> 4.11', '>= 4.11.1'
  s.add_dependency 'haml', '~> 4.0', '>= 4.0.7'
  s.add_dependency 'rectify', '~> 0.6.1'
  s.add_dependency 'drape', '~> 1.0.0.beta1'
  s.add_dependency 'wicked', '~> 1.3', '>= 1.3.1'
  s.add_dependency 'devise', '~> 4.2'
  s.add_dependency 'simple_form', '~> 3.3', '>= 3.3.1'
  s.add_dependency 'country_select', '~> 2.5', '>= 2.5.2'
  s.add_dependency 'credit_card_validations', '~> 3.2', '>= 3.2.2'
  s.add_dependency 'bootstrap-sass', '~> 3.3', '>= 3.3.7'
  s.add_dependency 'rails-controller-testing', '~> 1.0', '>= 1.0.1'
  s.add_dependency 'ffaker', '~> 2.2'
  s.add_dependency 'jquery-rails', '~> 4.2', '>= 4.2.1'
  s.add_dependency 'coffee-rails', '~> 4.2', '>= 4.2.1'
  s.add_dependency 'database_cleaner', '~> 1.5', '>= 1.5.3'

  s.add_development_dependency 'rspec-rails', '~> 3.5', '>= 3.5.2'
  s.add_development_dependency 'capybara', '~> 2.9', '>= 2.9.1'
  s.add_development_dependency 'capybara-screenshot', '~> 1.0', '>= 1.0.14'
  s.add_development_dependency 'factory_girl_rails', '~> 4.7'
  s.add_development_dependency 'shoulda-matchers', '~> 3.1', '>= 3.1.1'
  s.add_development_dependency 'codeclimate-test-reporter'
end
