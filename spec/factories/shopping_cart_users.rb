FactoryGirl.define do
  factory :user do
    password 'password'
    password_confirmation 'password'
    sequence(:email) { |n| "email-#{n}@some.domain" }

    factory :user_with_orders do
      after :create do |user|
        create :order_in_progress, user: user
        create :order_delivered, user: user
      end
    end
  end
end
