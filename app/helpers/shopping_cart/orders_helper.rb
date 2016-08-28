module ShoppingCart
  module OrdersHelper

    def back_to_shop_link
      link_to t('cart.back_to_shop'),
              main_app.root_path,
              class: 'btn btn-default'
    end

    def continue_shopping_link
      link_to t('cart.back_to_shop'),
              main_app.root_path,
              class: 'btn btn-default'
    end

    def link_to_checkout
      link_to t('cart.checkout'),
              checkout_index_path,
              class: 'btn btn-success'
    end

    def empty_cart_link id
      link_to t('cart.delete_order'),
              shopping_cart.order_path(id),
              method: :delete,
              class: 'btn btn-default'
    end

    def delete_item_link id
      link_to t('cart.delete_item'),
              shopping_cart.order_item_path(id),
              method: :delete,
              class: 'btn btn-default btn-sm'
    end
  end
end
