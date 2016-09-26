module ShoppingCart
  class ProceedCheckout < Rectify::Command
    def initialize(params, order, step)
      @params = params
      @order = order
      @step = step
    end

    def call
      return broadcast(:invalid) unless @params && @order
      transaction do
        case @step
          when :address  then AddCheckoutAddresses.call(@order, @params)
          when :delivery then AddCheckoutDelivery.call(@order, @params)
          when :payment  then AddCheckoutPayment.call(@order, @params)
          when :confirm  then PlaceOrder.call(@order)
          else call_custom_command
        end
      end
      @order.errors.any? ? broadcast(:validation) : broadcast(:ok)
    end

    private

    def call_custom_command
      custom_command = "ShoppingCart::#{@step.to_s.camelcase}CheckoutStep"
      custom_command.constantize.call(@order, @params)
    end
  end
end
