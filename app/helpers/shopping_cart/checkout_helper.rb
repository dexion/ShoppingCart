module ShoppingCart
  module CheckoutHelper
    def link_to_previous_step
      link_to t('checkout.previous_step'),
              previous_wizard_path,
              class: 'btn btn-default'
    end

    def link_to_confirmation
      link_to t('checkout.to_confirmation'),
              wizard_path(:confirm),
              class: 'btn btn-default'
    end

    def edit_link_to step
      link_to t('checkout.edit'), wizard_path(step)
    end

    def back_to_cart_link
      link_to t('checkout.to_cart'), root_path, class: 'btn btn-default'
    end

    def fill_address(customer, order, type, field)
      order.public_send(type).try(field)
    end

    def back_to_shop_link
      link_to t('checkout.back_to_shop'),
              main_app.root_path,
              class: 'btn btn-default'
    end

    def first_step? value
      value == wizard_steps[0]
    end

    def credit_card_available_years
      (Time.zone.now.year + 1)..(Time.zone.now.year + 3)
    end

    def credit_card_selected_year
      (Time.zone.now.year + 1)
    end

    def ready_to_confirm? order
      ValidateStep.call(:confirm, order) do
        on(:ok)       { return true }
        on(:invalid)  { return false }
      end
    end

    def confirm_step_col_size
      12/(ShoppingCart.checkout_steps.count - 2)
    end

    def edit_step_link type
      edit_link_to(type) if step == :confirm
    end
  end
end
