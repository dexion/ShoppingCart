module ShoppingCart
  class Address < ApplicationRecord
    belongs_to :order
    include Countries
  end
end
