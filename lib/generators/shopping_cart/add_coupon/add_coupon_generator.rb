module ShoppingCart
  class AddCouponGenerator < Rails::Generators::Base

    argument :code, type: :string
    argument :discount, type: :string

    def create_coupon
      ShoppingCart::Coupon.create code: code, discount: discount
    end

  end
end
