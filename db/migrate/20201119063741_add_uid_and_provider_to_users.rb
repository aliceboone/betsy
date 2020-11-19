class AddUidAndProviderToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :merchants, :uid, :integer
    add_column :merchants, :provider, :string
    add_column :merchants, :name, :string
  end
end
