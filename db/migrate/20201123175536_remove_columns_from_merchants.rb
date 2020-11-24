class RemoveColumnsFromMerchants < ActiveRecord::Migration[6.0]
  def change
    remove_column :merchants, :mailing_address
    remove_column :merchants, :credit_last_four
    remove_column :merchants, :credit_expire
  end
end
