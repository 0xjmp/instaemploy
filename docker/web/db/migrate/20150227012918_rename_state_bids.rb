class RenameStateBids < ActiveRecord::Migration
  def change
    remove_column :bids, :state, :string
    change_table :bids do |t|
      t.string :state, null: false, default: 'incomplete'
    end
  end
end
