class CreateShoppingCartDeliveries < ActiveRecord::Migration[5.0]
  def change
    create_table :shopping_cart_deliveries do |t|
      t.string :title
      t.float :price
      t.timestamps
    end
  end
end
