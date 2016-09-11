RSpec.describe 'Add To Cart button' do
  let(:user) { create :user }
  let(:product) { create :product, title: 'title' }

  before do
    login_as user, scope: :user
    visit main_app.product_path(product)
    within '#add_to_cart' do
      fill_in 'quantity', with: 3
    end
    click_button 'Add to cart'
  end

  it 'should add product to cart with right amount' do
    expect(page).to have_content I18n.t('cart.page_title')
    expect(page).to have_content 'title'
    expect(page).to have_selector 'input[value="3"]'
  end
end
