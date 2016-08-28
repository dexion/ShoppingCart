module ShoppingCart
  class UpdateOrder < Rectify::Command
    def initialize(order, params)
      @order = order
      @params = params
    end

    def call
      return broadcast(:invalid) if @order.invalid?
      transaction do
        join_coupon
        update_order
      end
      broadcast :ok
    end

    private

    def join_coupon
      coupon = Coupon.find_by(code: coupon_code)
      return unless coupon
      @order.coupon = coupon
    end

    def update_order
      @order.update(order_params)
    end

    def order_params
      @params.require(:order)
             .permit(:id, order_items_attributes: [:id, :quantity])
    end

    def coupon_code
      @params[:order][:coupon][:code] unless @order.coupon
    end
  end
end
