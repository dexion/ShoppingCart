require 'aasm'

module ShoppingCart
  class Order < ApplicationRecord
    has_many   :order_items, dependent: :destroy
    belongs_to :user, class_name: 'User'
    # belongs_to :credit_card
    belongs_to :delivery, optional: true
    has_one :coupon, dependent: :destroy
    has_one :shipping, dependent: :destroy
    has_one :billing, dependent: :destroy

    accepts_nested_attributes_for :order_items, allow_destroy: true

    after_validation :update_total

    include AASM
    # attr_accessor :active_admin_requested_event
    aasm column: :state, whiny_transitions: false do
      state :in_progress, initial: true
      state :processing
      state :in_delivery
      state :delivered
      state :canceled

      event :completed do
        transitions from: :in_progress, to: :processing
      end

      event :sent_to_client do
        transitions from: :processing, to: :in_delivery
      end

      event :delivered do
        transitions from: :in_delivery, to: :delivered
      end

      event :canceled do
        transitions from: [:processing, :in_delivery], to: :canceled
      end
    end

    def add_item(id, type, quantity = 1)
      item = order_items.where("productable_id = ? AND productable_type = ?", id, type).first
      if item
        item.update_amount(quantity)
      else
        order_items.create(quantity: quantity, productable_id: id, productable_type: type)
      end
    end

    def update_total
      return if errors.any?
      new_total = order_items.map(&:item_total).sum
      new_total -= (new_total * coupon.discount / 100) if coupon
      self.total = new_total
    end

    def destroy_if_orphant
      self.destroy if order_items.count.zero?
    end

    def has_all_data?
      billing && shipping && delivery
      # billing && shipping && credit_card && delivery
    end
  end
end
