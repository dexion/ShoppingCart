module ShoppingCart
  RSpec.describe OrderItemsController, type: :controller do
    routes { ShoppingCart::Engine.routes }

    login_user

    describe 'DELETE #destroy' do
      before do
        @item = create :order_item
      end

      it 'deletes requested item' do
        expect{
          delete :destroy, params: { id: @item.id }
        }.to change(OrderItem, :count).by(-1)
      end
    end
  end
end
