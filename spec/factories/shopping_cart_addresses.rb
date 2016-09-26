module ShoppingCart
  FactoryGirl.define do
    factory :address, class: Address do
      first_name { FFaker::Name.first_name }
      last_name { FFaker::Name.last_name }
      street { FFaker::AddressUS.street_address }
      zipcode { FFaker::AddressUS.zip_code }
      city { FFaker::AddressUS.city }
      phone '+380971234567'
      country_code { FFaker::Address.country_code }
    end
  end
end
