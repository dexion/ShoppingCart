require "#{ShoppingCart::Engine.root}/lib/validators/shopping_cart/expiration_validator.rb"

module ShoppingCart
  class CreditCardForm < Rectify::Form
    include ActiveModel::Validations

    attribute :first_name, String
    attribute :last_name,  String
    attribute :number,     String
    attribute :cvv,       Integer
    attribute :year,      Integer
    attribute :month,     Integer

    validates :number,
              presence: true,
              credit_card_number: true

    validates :cvv,
              presence: true,
              numericality: { only_integer: true },
              length: { is: 3 }

    validates :first_name, :last_name,
              presence: true

    validates :year,
              presence: true,
              numericality: { only_integer: true }

    validates :month,
              presence: true,
              numericality: {
                  only_integer: true,
                  greater_than_or_equal_to: 1,
                  less_than_or_equal_to: 12
              }

    validates_with ShoppingCart::ExpirationValidator
  end
end
