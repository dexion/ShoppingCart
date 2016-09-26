module ShoppingCart
  class Delivery < ActiveRecord::Base
    has_many :orders

    validates :title,
              presence: true,
              uniqueness: true

    validates :price,
              presence: true
  end
end
