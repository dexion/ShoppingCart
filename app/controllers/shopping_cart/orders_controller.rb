module ShoppingCart
  class OrdersController < ApplicationController
    # before_action :set_order, only: [:update, :destroy]

    # decorates_assigned :order

    # def index
    #   @orders = current_customer.orders
    # end
    #
    # def show
    #   @order = Order.with_books.find_by(id: params[:id])
    #   back_to_shop('Order') unless @order
    # end

    def edit
      @order = Order.where(user_id: current_user.id).in_progress.first
    end

    # def update
    #   UpdateOrder.call(@order, params) do
    #     on(:ok)      { updated_notice('Order') }
    #     on(:invalid) { update_error('Order') }
    #   end
    #   redirect_to cart_path
    # end
    #
    # def destroy
    #   @order.destroy ? deleted_notice('Order') : delete_error('Order')
    #   redirect_to cart_path
    # end
    #
    def create
      CreateOrder.call(params) do
        on(:ok)       { redirect_to root_path }
        on(:invalid)  { redirect_to root_path, error: 'error without I18n' }
      end
    end

    # private

    # def set_order
    #   @order = Order.find_by_id params[:id]
    # end
  end
end
