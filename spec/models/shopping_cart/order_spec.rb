module ShoppingCart
  RSpec.describe Order, type: :model do
    subject(:order) { create :order }

    describe "relations" do
      it { should have_many(:order_items).dependent(:destroy) }
      it { should belong_to :user }
      it { should belong_to :credit_card }
      it { should belong_to :delivery }
      it { should have_one :coupon }
      it { should have_one :shipping }
      it { should have_one :billing }
    end

    describe 'states' do
      it { expect(order).to have_state(:in_progress) }
      it { expect(order).to transition_from(:in_progress).to(:processing).on_event(:completed) }
      it { expect(order).to transition_from(:processing).to(:in_delivery).on_event(:sent_to_client) }
      it { expect(order).to transition_from(:in_delivery).to(:delivered).on_event(:delivered) }
      it { expect(order).to transition_from(:processing).to(:canceled).on_event(:canceled) }
      it { expect(order).to transition_from(:in_delivery).to(:canceled).on_event(:canceled) }
    end

    describe "#total" do
      it "has total 0 if no order_items added" do
        order.save
        expect(order.total).to eq(0)
      end

      it "updates total after validation" do
        order.order_items << create(:order_item)
        order.save
        expect(order.total).to be > 0
      end
    end

    describe "when last order_item destroyed" do
      before do
        order.order_items << create(:order_item, id: 1)
      end

      let(:destroy_oi) { OrderItem.find(1).destroy }

      it "self.destroy" do
        expect { destroy_oi }.to change { Order.count }.by(-1)
      end
    end

    describe '#add_item' do

      describe 'when order_item' do
        before { @order = create :order }
        let(:product) { create :product, id: 1 }
        let(:items_amount) { @order.order_items.count }
        let(:add_item) { @order.add_item(product.id, product.class, 1) }

        context 'is already in order' do
          before do
            @oi = create :order_item,
                         productable_id: product.id,
                         productable_type: product.class,
                         order: @order
          end

          it 'should increase quantity' do
            expect{ add_item }.to change{
              @order.order_items.where("productable_id = ? AND productable_type = ?", product.id, product.class).first.quantity
            }.by(1)
          end

          it 'should not create new order_item' do
            expect { add_item }.not_to change { @order.order_items.count }
          end
        end

        context 'is not in order' do
          it 'should create new order_item' do
            expect { add_item }.to change { @order.order_items.count }.by(1)
          end
        end
      end
    end
  end
end
