class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :status
      t.string :email
      t.string :address
      t.string :credit_name
      t.string :credit_expire
      t.string :security_code
      t.integer :zip

      t.timestamps
    end
  end
end
