module ShoppingCart
  class OrderInProgress < Rectify::Query
    def initialize id
      @id = id
    end

    def query
      Order.where(user_id: @id).in_progress.first.try(:decorate)
    end
  end
end
