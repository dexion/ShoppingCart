class CreateShoppingCartOrderItems < ActiveRecord::Migration[5.0]
  def change
    create_table :shopping_cart_order_items do |t|
      t.integer :quantity
      t.belongs_to :order, index: true
      t.references :productable, polymorphic: true, index: {name: 'productable'}
      t.timestamps
    end
  end
end
