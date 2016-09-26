module ShoppingCart
  FactoryGirl.define do
    factory :order, class: Order do
      user
      
      factory :order_in_progress do
        after :create do |order|
          product = create :product
          create :order_item,
                 productable_id: product.id,
                 productable_type: product.class,
                 quantity: 2,
                 order: order
        end

        factory :order_delivered do
          after :create do |order|
            order.update state: :delivered
          end
        end
      end

      factory :order_with_coupon do
        after :create do |order|
          order.coupon = create :coupon
        end
      end
    end
  end
end
