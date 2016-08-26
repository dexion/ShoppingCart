$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "shopping_cart/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "shopping_cart"
  s.version     = ShoppingCart::VERSION
  s.authors     = ["Kirill Oleynik"]
  s.email       = ["kirill.olejnik@gmail.com"]
  s.homepage    = "https://github.com/kirill-oleynik/ShoppingCart"
  s.summary     = "RubyGarage hometask"
  s.description = "Cart & checkout engine"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.0", ">= 5.0.0.1"
  s.add_dependency 'pg'
  s.add_dependency 'aasm'
  s.add_dependency 'haml'
  s.add_dependency 'rectify'
  s.add_dependency 'drape'
  s.add_dependency 'wicked'
  s.add_dependency 'simple_form'
  s.add_dependency 'country_select'
  s.add_dependency 'credit_card_validations'
end
