module ShoppingCart
  class GetCheckoutData < Rectify::Command
    def initialize(order, step)
      @order = order
      @step = step
    end

    def call
      return get_data
    end

    private

    def get_data
      case @step
        when :delivery then DeliveryForCheckout.new().query
        else custom_query
      end
    end

    def custom_query
      query = "ShoppingCart::#{@step.to_s.camelcase}ForCheckout"
      query.constantize.try(:new, @order).try(:query) rescue false
    end
  end
end
