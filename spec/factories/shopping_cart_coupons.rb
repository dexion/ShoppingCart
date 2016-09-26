module ShoppingCart
  FactoryGirl.define do
    factory :coupon, class: Coupon do
      code { FFaker::CheesyLingo.word }
      discount 5
    end
  end
end
