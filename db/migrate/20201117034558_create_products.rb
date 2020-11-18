class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.integer :inventory
      t.integer :price
      t.string :category
      t.string :photo
      t.integer :rating

      t.timestamps
    end
  end
end
