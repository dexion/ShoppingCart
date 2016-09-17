require_dependency "shopping_cart/application_controller"

module ShoppingCart
  class OrderItemsController < ApplicationController

    def destroy
      OrderItem.find_by_id(params[:id]).destroy
      redirect_to root_path
    end

  end
end
