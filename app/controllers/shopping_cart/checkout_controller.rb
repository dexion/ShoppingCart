require_dependency "shopping_cart/application_controller"

module ShoppingCart
  class CheckoutController < ApplicationController
    include Wicked::Wizard

    before_action :set_steps
    before_action :setup_wizard
    before_action :set_order

    def show
      @step = step
      @deliveries = Delivery.all.decorate
      ValidateStep.call(@step, @order) do
        on(:ok)       { render_wizard }
        on(:invalid)  { redirect_to root_path }
      end
    end

    def update
      ProceedCheckout.call(params, @order, step) do
        on(:ok)         { render_wizard @order }
        on(:invalid)    { redirect_to root_path }
        on(:validation) { render_wizard }
      end
    end

    private

    def set_order
      @order = OrderForCheckout.new(current_user.id, step).query
      redirect_to(root_path) unless @order
    end

    def set_steps
      self.steps = ShoppingCart.checkout_steps
    end
  end
end
