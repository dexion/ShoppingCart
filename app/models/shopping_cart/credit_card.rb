module ShoppingCart
  class CreditCard < ApplicationRecord
    has_many :orders
  end
end
