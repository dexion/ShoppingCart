module ShoppingCart
  RSpec.describe 'Checkout' do
    let(:user) { create :user_with_orders }

    before do
      login_as user, scope: :user
      visit shopping_cart.root_path
      click_link I18n.t('cart.checkout')
    end

    describe 'Address step' do
      let(:address) { attributes_for :address }
      before do
        within '#billing_fields' do
          fill_in 'billing[address][first_name]', with: address[:first_name]
          fill_in 'billing[address][last_name]', with: address[:last_name]
          fill_in 'billing[address][street]', with: address[:street]
          fill_in 'billing[address][city]', with: address[:city]
          fill_in 'billing[address][zipcode]', with: address[:zipcode]
          fill_in 'billing[address][phone]', with: address[:phone]
        end
      end

      context 'when all fields valid' do
        it 'should show next step' do
          click_button 'Save & continue'
          expect(page).not_to have_content I18n.t('billing_address')
          expect(page).not_to have_content I18n.t('shipping_address')
        end
      end

      context 'when have invalid fields' do
        before do
          within '#billing_fields' do
            fill_in 'billing[address][zipcode]', with: ''
          end
        end

        it 'should show errors' do
          click_button I18n.t('checkout.continue')
          expect(page).to have_content I18n.t('general.prohibited_from_save')
        end
      end

      describe 'Delivery step' do
        before do
          create :delivery, title: 'del_1'
          create :delivery, title: 'del_2'
          click_button I18n.t('checkout.continue')
        end

        it 'should show available delivery types' do
          expect(page).to have_content I18n.t('checkout.deliveries')
          expect(page).to have_content 'del_1'
          expect(page).to have_content 'del_2'
        end

        describe 'Payment step' do
          before do
            choose('order[delivery_id]', match: :first)
            click_button I18n.t('checkout.continue')
          end

          it 'should show credit card form' do
            expect(page).to have_content I18n.t('checkout.credit_card')
          end

          describe 'credit card information' do
            before do
              card = create :credit_card
              within '#payment_fields' do
                fill_in 'order[credit_card_attributes][first_name]', with: card.first_name
                fill_in 'order[credit_card_attributes][last_name]', with: card.last_name
                fill_in 'order[credit_card_attributes][number]', with: card.number
                fill_in 'order[credit_card_attributes][cvv]', with: card.cvv
              end
            end

            context 'valid' do
              before { click_button I18n.t('checkout.continue') }

              it 'should go to confirmation step' do
                expect(page).to have_content I18n.t('checkout.confirm_order')
              end
            end

            context 'invalid' do
              before do
                within '#billing_fields' do
                  fill_in 'name="order[credit_card_attributes][first_name]"', with: ''
                  click_button I18n.t('checkout.continue')
                end

                it 'should show error' do
                  expect(page).to have_content I18n.t('general.prohibited_from_save')
                end
              end
            end

            describe 'Confirmation step' do
              before do
                click_button I18n.t('checkout.continue')
              end

              it 'should go to confirmation page' do
                expect(page).to have_content I18n.t('checkout.confirm_order')
              end

              describe 'Edit shipping address' do
                before do
                  within '#shipping_block' do
                    find("a[href='/cart/checkout/address']").click
                  end
                end

                it 'should go to edit address step' do
                  expect(page).to have_content I18n.t('checkout.billing')
                  expect(page).to have_content I18n.t('checkout.shipping')
                end
              end

              describe 'Edit billing address' do
                before do
                  within '#billing_block' do
                    find("a[href='/cart/checkout/address']").click
                  end
                end

                it 'should go to edit address step' do
                  expect(page).to have_content I18n.t('checkout.billing')
                  expect(page).to have_content I18n.t('checkout.shipping')
                end
              end

              describe 'Edit delivery' do
                before do
                  within '#delivery_block' do
                    find("a[href='/cart/checkout/delivery']").click
                  end
                end

                it 'should go to edit delivery step' do
                  expect(page).to have_content I18n.t('checkout.deliveries')
                end
              end

              describe 'Edit payment' do
                before do
                  within '#payment_block' do
                    find("a[href='/cart/checkout/payment']").click
                  end
                end

                it 'should go to edit payment step' do
                  expect(page).to have_content I18n.t('checkout.credit_card')
                end
              end

              describe 'Place order' do
                before { click_button I18n.t('checkout.place_order') }

                it 'should go to completed page' do
                  expect(page).to have_content 'Order'
                end
              end
            end
          end
        end
      end
    end
  end
end
