class CreateCategoriesProductsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :categories_products do |t|
      t.references :product
      t.references :category
    end
  end
end
