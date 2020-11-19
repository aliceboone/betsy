class CreateMerchants < ActiveRecord::Migration[6.0]
  def change
    create_table :merchants do |t|
      t.string :username
      t.string :email
      t.string :mailing_address
      t.string :credit_last_four
      t.string :credit_expire

      t.timestamps
    end
  end
end
