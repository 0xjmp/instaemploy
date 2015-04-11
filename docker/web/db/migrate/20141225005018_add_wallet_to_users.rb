class AddWalletToUsers < ActiveRecord::Migration
  def change
    add_column :users, :wallet, :float, default: 0, null: false
  end
end
