class AddCodeToBids < ActiveRecord::Migration
  def change
    add_column :bids, :code, :text
  end
end
