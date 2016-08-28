module ShoppingCart
  class OrderDecorator < Drape::Decorator
    delegate_all

    def total_in_currency
      h.number_to_currency object.total
    end

    def total_with_delivery
      h.number_to_currency(object.total + object.delivery.price)
    end

    def discount
      h.number_to_percentage(object.coupon.discount, precision: 1)
    end
  end
end
