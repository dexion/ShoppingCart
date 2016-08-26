module ShoppingCart
  class PlaceOrder < Rectify::Command
    def initialize(order, params)
      @order = order
      @params = params
    end

    def call
      place_order if order_valid?
    end

    private

    def order_valid?
      nested_models.all? { |model| @order.public_send(model).valid? }
    end

    def nested_models
      [:shipping, :billing, :credit_card, :delivery]
    end

    def place_order
      @order.completed
      @order.save
    end
  end
end
