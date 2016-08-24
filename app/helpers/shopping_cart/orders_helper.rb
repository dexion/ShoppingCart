module ShoppingCart
  module OrdersHelper
    # def back_to_orders_link
    #   regular_link t('show.back_to_orders'), orders_path
    # end
    #
    # def back_to_shop_link
    #   regular_link t('index.back_to_shop'), books_path
    # end
    #
    # def current_order_link_to_cart
    #   regular_link t('index.to_cart').upcase, cart_path
    # end
    #
    # def continue_shopping_link
    #   regular_link t('orders.edit.to_shop'), books_path
    # end
    #
    # def link_to_checkout
    #   link_to t('orders.edit.checkout'),
    #           checkout_index_path,
    #           class: 'btn btn-primary'
    # end
    #
    # def empty_cart_link order
    #   link_to t('orders.edit.empty_cart'),
    #           order,
    #           method: :delete,
    #           class: 'btn btn-success'
    # end

    def delete_item_link id
      link_to t('cart.delete_item'),
              shopping_cart.order_item_path(id),
              method: :delete,
              class: 'btn btn-default btn-sm'
    end

    # def delete_item_button id
    #   link_to t('cart.delete_item'),
    #           order_item_path(id),
    #           method: :delete,
    #           class: 'btn btn-default btn-sm'
    # end

    # def link_to_order_show order
    #   link_to t('index.view'),
    #           order,
    #           class: 'btn btn-sm btn-default'
    # end
  end
end
