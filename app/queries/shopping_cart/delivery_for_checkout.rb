module ShoppingCart
  class DeliveryForCheckout < Rectify::Query
    def query
      Delivery.all.decorate
    end
  end
end
