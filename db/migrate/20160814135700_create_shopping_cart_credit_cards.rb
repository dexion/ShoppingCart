class CreateShoppingCartCreditCards < ActiveRecord::Migration[5.0]
  def change
    create_table :shopping_cart_credit_cards do |t|
      t.string :number
      t.string :cvv
      t.integer :year
      t.integer :month
      t.string :first_name
      t.string :last_name
      t.belongs_to :order, index: true
      t.timestamps
    end
  end
end
