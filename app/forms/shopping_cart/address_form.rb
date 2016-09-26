module ShoppingCart
  class AddressForm < Rectify::Form
    attribute :first_name,   String
    attribute :last_name,    String
    attribute :street,       String
    attribute :city,         String
    attribute :zipcode,      String
    attribute :phone,        String
    attribute :country_code, String
    attribute :order_id,     Integer

    validates :first_name,
              :last_name,
              :street,
              :city,
              :zipcode,
              :phone,
              :country_code,
              :order_id,
              presence: true

    validates :phone, format: { with: /\A\+\d{12}\z/ }
  end
end
