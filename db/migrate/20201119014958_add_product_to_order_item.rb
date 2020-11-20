class AddProductToOrderItem < ActiveRecord::Migration[6.0]
  def change
    add_reference :order_items, :product
  end
end
