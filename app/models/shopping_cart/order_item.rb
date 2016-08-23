module ShoppingCart
  class OrderItem < ApplicationRecord
    belongs_to :productable, polymorphic: true
    belongs_to :order

    validates :quantity, presence: true
    validates :quantity, numericality: {
                          only_integer: true,
                          greater_than_or_equal_to: 1
                        }

    delegate :destroy_if_orphant, to: :order
    after_destroy :destroy_if_orphant

    # def update_amount amount
    #   summ = quantity + amount
    #   self.update(quantity: summ)
    # end

    def item_total
      quantity * productable.price
    end
  end
end
