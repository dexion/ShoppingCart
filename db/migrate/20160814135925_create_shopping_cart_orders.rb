class CreateShoppingCartOrders < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'uuid-ossp'
    create_table :shopping_cart_orders do |t|
      t.float :total
      t.string :state
      t.uuid :number, default: "uuid_generate_v4()"
      t.belongs_to :delivery, index: true
      t.belongs_to :credit_card, index: true
      t.belongs_to :user, index: true
      t.timestamp :completed_at
      t.timestamps
    end
  end
end
