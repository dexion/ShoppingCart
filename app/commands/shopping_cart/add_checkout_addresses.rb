module ShoppingCart
  class AddCheckoutAddresses < Rectify::Command
    def initialize(order, params)
      @order = order
      @params = params
    end

    def call
      @billing = address :billing
      @billing.valid? ? save_billing : write_errors(:billing, @billing)

      @shipping = use_billing? ? address(:billing) : address(:shipping)
      @shipping.valid? ? save_shipping : write_errors(:shipping, @shipping)
    end

    private

    def address type
      AddressForm.from_params(@params[type])
    end

    def save_billing
      @order.billing = Billing.create @billing.to_h
    end

    def save_shipping
      @order.shipping = Shipping.create @shipping.to_h
    end

    def use_billing?
      @params[:order][:use_billing][:allow] == '1'
    end

    def write_errors(type, address)
      @order.errors[type].concat address.errors.full_messages
    end
  end
end
