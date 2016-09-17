module ShoppingCart
  class PlaceOrder < Rectify::Command
    def initialize(order)
      @order = order
    end

    def call
      ValidateStep.call(:confirm, @order) do
        on(:ok)       { place_order }
        on(:invalid)  { redirect_to root_path }
      end
    end

    private

    def place_order
      @order.completed
      @order.save
    end
  end
end
