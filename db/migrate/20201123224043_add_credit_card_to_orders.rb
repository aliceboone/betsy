class AddCreditCardToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :credit_card_number, :string
  end
end
