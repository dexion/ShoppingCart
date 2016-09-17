module ShoppingCart
  class AddDeliveryGenerator < Rails::Generators::Base
  
    argument :title, type: :string
    argument :price, type: :string

    def create_delivery_method
      ShoppingCart::Delivery.create title: title, price: price
    end
  end
end