class CreateShoppingCartCoupons < ActiveRecord::Migration[5.0]
  def change
    create_table :shopping_cart_coupons do |t|
      t.string :code
      t.float :discount
      t.belongs_to :order, index: true
      t.timestamps
    end
  end
end
