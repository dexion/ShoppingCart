module ShoppingCart
  RSpec.describe OrderItem, type: :model do
    subject(:order_item) { create :order_item }
    it { should belong_to :order }
    it { should belong_to :productable }
    it { should validate_presence_of :quantity }
    it { should validate_numericality_of :quantity }
  end
end
