module ShoppingCart
  class OrderDecorator < Drape::Decorator
    delegate_all
    # decorates_association :order_item

    # def number_and_state
    #   h.t('show.order_name_html', num: object.number, state: object.state)
    # end

    def total_in_currency
      h.number_to_currency object.total
    end

    # def completed_at
    #   h.l(object.created_at, format: :full)
    # end

    def total_with_delivery
      h.number_to_currency(object.total + object.delivery.price)
    end

    def discount
      h.number_to_percentage(object.coupon.discount, precision: 1)
    end
  end
end
