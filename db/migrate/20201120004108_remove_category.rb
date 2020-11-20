class RemoveCategory < ActiveRecord::Migration[6.0]
  def change
    remove_column :products, :category
  end
end
