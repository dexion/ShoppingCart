module ShoppingCart
  RSpec.describe Address, type: :model do
    it { should belong_to :order }
  end
end
