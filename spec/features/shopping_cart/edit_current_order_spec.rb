module ShoppingCart
  RSpec.describe 'Edit orders' do
    before { login_as user, scope: :user }
    let(:user) { user = create :user_with_orders }

    it 'should update order' do
      visit shopping_cart.root_path
      within '.edit_order' do
        fill_in 'order[order_items_attributes][0][quantity]', with: 10
      end
      click_button I18n.t('cart.update_order')

      expect(page).to have_content I18n.t('flash.updated', obj: 'Order')
      expect(page).to have_selector("input[value='10']")
    end
  end
end
