module ShoppingCart
  RSpec.describe CreditCard, type: :model do
    it { should have_many :orders }
  end
end
