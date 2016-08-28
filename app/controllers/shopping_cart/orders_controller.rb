module ShoppingCart
  class OrdersController < ApplicationController
    include ShoppingCart::StandardFlashes

    before_action :authenticate_user!
    before_action :set_order, only: [:update, :destroy]

    def edit
      @order = OrderInProgress.new(current_user.id).query
    end

    def update
      UpdateOrder.call(@order, params) do
        on(:ok)      { updated_notice('Order') }
        on(:invalid) { update_error('Order') }
      end
      redirect_to root_path
    end

    def destroy
      @order.destroy
      redirect_to root_path
    end

    def create
      CreateOrder.call(params) do
        on(:ok)       { redirect_to root_path }
        on(:invalid)  { create_order_failed }
      end
    end

    private

    def set_order
      @order = Order.find_by_id params[:id]
    end
  end
end
