class CreateShoppingCartAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :shopping_cart_addresses do |t|
      t.string :street
      t.string :zipcode
      t.string :city
      t.string :phone
      t.string :first_name
      t.string :last_name
      t.string :country_code
      t.string :type
      t.belongs_to :order, index: true
      t.timestamps
    end
  end
end
