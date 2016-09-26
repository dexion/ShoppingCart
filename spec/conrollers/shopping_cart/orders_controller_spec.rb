module ShoppingCart
  RSpec.describe OrdersController, type: :controller do
    routes { ShoppingCart::Engine.routes }

    login_user

    context 'view and edit' do
      describe 'GET #edit' do
        before { get :edit }

        it 'renders #edit' do
          expect(response).to render_template :edit
        end
      end

      describe 'PUT/PATCH #update' do
        before do
          @oi = create :order_item
          @order = create :order_with_coupon
          @order.order_items << @oi
        end

        context 'when order updated' do
          before do
            put :update, params: {
              order: {order_items_attributes: {0 => {quantity: 7, id: @oi.id}}}, id: @order.id
            }
          end

          it "flash notice 'updated'" do
            expect(flash[:notice]).to eq I18n.t('flash.updated', obj: 'Order')
          end

          it 'redirects back' do
            expect(response).to redirect_to root_path
          end
        end
      end
    end

    describe 'POST #create' do
      before do
        allow(OrderItem).to receive(:create).and_return('order_item')
        create :product, id: 0
      end

      let(:user) { create :user }
      let(:product) { create :product }

      describe 'when order in_progress' do
        context 'exitsts' do
          # let(:user) { create :user_with_orders }

          it 'should not create new order' do
            expect {
              post :create, params: { product: product, quantity: 1 }
            }.not_to change { Order.count }
          end

          describe 'when order_item with that product' do
            context 'exists' do
              let(:product) { create :product, id: 1 }
              let(:user) { create :user, id: 1 }

              before do
                post :create,
                     params: {product: product, quantity: 1}
              end

              it 'should not create new order_item' do
                expect {
                  post :create,
                       params: {product: product, quantity: 1}
                }.not_to change { OrderItem.count }
              end
            end

            context 'not exists' do
              it 'should create new order_item' do
                expect {
                  post :create,
                       params: {productable_id: product.id,
                                productable_type: product.class,
                                quantity: 1}
                }.to change { OrderItem.count }.by(1)
              end
            end
          end
        end

        context 'not exists' do
          let(:user) { create :user }

          it 'should create new order' do
            expect {
              post :create,
                   params: {productabe_id: product.id,
                            productable_type: product.class,
                            quantity: 1}
            }.to change { Order.count }.by(1)
          end

          it 'should create new order_item' do
            expect {
              post :create,
                   params: {productable_id: product.id,
                            productable_type: product.class,
                            quantity: 1}
            }.to change { OrderItem.count }.by(1)
          end
        end

        describe 'redirect_to' do
          let :main_app do
            Rails.application.class.routes.url_helpers
          end

          it 'cart' do
            post :create,
                 params: {product: product, quantity: 1}
            expect(response).to redirect_to main_app.root_path
          end
        end
      end
    end
  end
end
