class AddPendingToBids < ActiveRecord::Migration
  def change
    add_column :bids, :pending, :boolean, default: true, null: false
  end
end
