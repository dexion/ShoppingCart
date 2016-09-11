module ShoppingCart
  RSpec.describe Coupon, type: :model do
    subject(:coupon) { create :coupon }

    describe 'validations' do
      it { should belong_to :order }
      it { should validate_presence_of :code }
      it { should validate_presence_of :discount }

      describe 'when discount is' do
        context 'less than 0 it' do
          it 'should be invalid' do
            expect(build :coupon, discount: -10).not_to be_valid
          end
        end
        context 'greater than 100' do
          it 'should be invalid' do
            expect(build :coupon, discount: 120).not_to be_valid
          end
        end
      end
    end
  end
end
