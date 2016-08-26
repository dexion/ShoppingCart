module ShoppingCart
  class ExpirationValidator < ActiveModel::Validator
    def validate(record)
      return if record.errors.any?
      expiration = Date.new(record.year, record.month)
      current = Date.today.change(day: 1)
      record.errors.add(:base, "card is exprired") if expiration < current
    end
  end
end
