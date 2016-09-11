module ShoppingCart
  RSpec.describe 'Coupon' do
    before do
      login_as user, scope: :user
      visit shopping_cart.root_path
    end

    let(:user) { create :user_with_orders }

    context 'when exists' do
      before do
        within '.edit_order' do
          fill_in 'order[coupon][code]', with: coupon.code
          click_button I18n.t('cart.update_order')
        end
      end

      let(:coupon) { create :coupon }

      it 'should apply coupon' do
        expect(page).to have_content I18n.t('cart.discount')
      end
    end

    context 'when not exists' do
      before do
        within '.edit_order' do
          fill_in 'order[coupon][code]', with: 'lalala'
          click_button I18n.t('cart.update_order')
        end

        it 'should say that coupon does not exist' do
          expect(page).not_to have_content I18n.t('cart.discount')
        end
      end
    end
  end
end
