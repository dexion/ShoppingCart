module ShoppingCart
  RSpec.describe 'Empty cart' do
    before do
      login_as user, scope: :user
      visit shopping_cart.root_path
      within '.edit_order' do
        click_link I18n.t('cart.delete_order')
      end
    end

    let(:user) { create :user_with_orders }

    it 'should delete current order' do
      expect(page).to have_content I18n.t('cart.empty_cart')
    end
  end
end
