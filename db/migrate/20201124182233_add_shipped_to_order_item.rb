class AddShippedToOrderItem < ActiveRecord::Migration[6.0]
  def change
    add_column :order_items, :shipped, :boolean
  end
end
