module ShoppingCart
  FactoryGirl.define do
    factory :credit_card, class: CreditCard do
      number { CreditCardValidations::Factory.random :visa }
      cvv '123'
      year { Date.today.year }
      month { Date.today.month }
      first_name { FFaker::Name.first_name }
      last_name { FFaker::Name.last_name }
    end
  end
end
