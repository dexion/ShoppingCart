module ShoppingCart
  FactoryGirl.define do
    factory :order_item, class: OrderItem do
      quantity 1
      order
      association :productable, factory: :product
    end
  end
end
