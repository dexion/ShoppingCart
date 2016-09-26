module ShoppingCart
  class AddCheckoutDelivery < Rectify::Command
    def initialize(order, params)
      @order = order
      @params = params
    end

    def call
      update_delivery
    end

    private

    def update_delivery
      @order.update_attributes delivery_params
    end

    def delivery_params
      @params.require(:order).permit(:delivery_id)
    end
  end
end
