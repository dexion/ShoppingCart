module ShoppingCart
  RSpec.describe CreditCardForm do

    subject(:card) { CreditCardForm.from_params(attributes_for :credit_card) }

    describe 'expiration date' do
      it 'is invalid if month is lower than 1' do
        card.month = 0
        is_expected.not_to be_valid
      end

      it 'is invalid if month is greater than 12' do
        card.month = 13
        is_expected.not_to be_valid
      end

      describe 'expiration validator' do
        it "is invalid when #{ Date.today.year - 1 } - #{ Date.today.month }" do
          card.year = Date.today.year - 1
          is_expected.not_to be_valid
        end
        it "is valid when #{ Date.today.year + 1 } - #{ Date.today.month }" do
          card.year = Date.today.year + 1
          is_expected.to be_valid
        end
        it 'is valid when current' do
          card.year = Date.today.year
          card.month = Date.today.month
          is_expected.to be_valid
        end
      end
    end

    describe 'card number' do
      it 'is invalid if number is not real' do
        card.number = '1234 5678 8765 4321'
        expect(card).not_to be_valid
      end
    end
  end
end
