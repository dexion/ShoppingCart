module ShoppingCart
  class ValidateStep < Rectify::Command
    def initialize(step, order)
      @step = step
      @order = order
    end

    def call
      return broadcast(:invalid) unless @step && @order
      if order_has_data_for(@step)
        broadcast(:ok)
      else
        broadcast(:invalid)
      end
    end

    private

    def order_has_data_for step
      case step
        when :address  then true
        when :delivery then has_address? ?          true : false
        when :payment  then has_address_delivery? ? true : false
        when :confirm  then has_all_data? ?         true : false
        when :complete then true
        else
          false
      end
    end

    def has_address?
      @order.billing && @order.shipping
    end

    # def has_address_delivery?
    #   has_address? && @order.delivery
    # end
    #
    # def has_all_data?
    #   has_address_delivery? && @order.credit_card
    # end
  end
end
