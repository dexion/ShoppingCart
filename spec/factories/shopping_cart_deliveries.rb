module ShoppingCart
  FactoryGirl.define do
    factory :delivery, class: Delivery do
      title { FFaker::CheesyLingo.title }
      price 5
    end
  end
end
