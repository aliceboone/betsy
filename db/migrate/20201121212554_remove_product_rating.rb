class RemoveProductRating < ActiveRecord::Migration[6.0]
  def change
    remove_column :products, :rating
  end
end
