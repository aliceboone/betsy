class AddDiscontinuedToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :discontinued, :boolean, default: false
  end
end
