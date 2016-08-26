module ShoppingCart
  module CheckoutHelper
    def link_to_previous_step
      link_to t('checkout.previous_step'),
              previous_wizard_path,
              class: 'btn'
    end

    def link_to_confirmation
      link_to t('checkout.to_confirmation'),
              wizard_path(:confirm),
              class: 'btn btn-success'
    end

    def edit_link_to step
      link_to t('checkout.edit'), wizard_path(step)
    end

    def back_to_cart_link
      link_to t('checkout.to_cart'), root_path, class: 'btn'
    end

    def fill_address(customer, order, type, field)
      order.public_send(type).try(field)
    end
  end
end
