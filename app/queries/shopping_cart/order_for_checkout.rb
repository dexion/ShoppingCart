module ShoppingCart
  class OrderForCheckout < Rectify::Query
    def initialize(id, step)
      @id = id
      @state = (step == :complete) ? :processing : :in_progress
    end

    def query
      Order.where(user_id: @id)
           .where(state: @state).last
           .try(:decorate)
    end
  end
end
