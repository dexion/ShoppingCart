module ShoppingCart
  class OrderItemsController < ApplicationController
    before_action :authenticate_user!

    def destroy
      OrderItem.find_by_id(params[:id]).destroy
      redirect_to root_path
    end
  end
end
