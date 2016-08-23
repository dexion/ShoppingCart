module ShoppingCart
  class CreateOrder < Rectify::Command
    def initialize(params)
      @id = params[:productable_id].to_i
      @type = params[:productable_type]
      @quantity = params[:quantity].to_i
    end

    def call
      return broadcast(:invalid) unless @id && @type && @quantity
      transaction do
        add_item_to_order
      end
      broadcast :ok
    end

    private

    def add_item_to_order
      order_in_progress.add_item(@id, @type, @quantity)
      order_in_progress.save
    end

    def order_in_progress
      id = current_user.id
      Order.in_progress.find_by(user_id: id) || Order.create(user_id: id)
    end
  end
end
