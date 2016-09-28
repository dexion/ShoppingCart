module ShoppingCart
  class ValidateStep < Rectify::Command
    def initialize(step, order)
      @step = step
      @order = order
    end

    def call
      return broadcast(:invalid) unless @step && @order
      all_steps_valid? ? broadcast(:ok) :  broadcast(:invalid)
    end

    private

    def all_steps_valid?
      steps_to_validate.all? do |step|
        order_has_data_for? step
      end
    end

    def steps_to_validate
      steps = ShoppingCart.config.checkout_steps
      steps[0...steps.index(@step)]
    end

    def order_has_data_for? step
      case step
        when :address  then has_address?  ? true : false
        when :delivery then has_delivery? ? true : false
        when :payment  then has_payment?  ? true : false
        when :confirm  then confirmed?    ? true : false
        else custom_validation(step)      ? true : false
      end
    end

    def has_address?
      @order.billing.try(:valid?) && @order.shipping.try(:valid?)
    end

    def has_delivery?
      @order.delivery.try(:valid?)
    end

    def has_payment?
      @order.credit_card.try(:valid?)
    end

    def confirmed?
      @order.processing?
    end

    def custom_validation step
      @order.try(step).try(:valid?)
    end
  end
end
