class AddMerchantToProduct < ActiveRecord::Migration[6.0]
  def change
    add_reference :products, :merchant
  end
end
