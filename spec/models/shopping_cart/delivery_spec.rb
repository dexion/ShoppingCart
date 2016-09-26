module ShoppingCart
  RSpec.describe Delivery, type: :model do
    it { should have_many :orders }
    it { should validate_presence_of :price }
    it { should validate_presence_of :title }
    it { should validate_uniqueness_of :title }
  end
end
