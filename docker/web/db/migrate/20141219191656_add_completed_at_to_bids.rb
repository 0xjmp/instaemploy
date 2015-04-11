class AddCompletedAtToBids < ActiveRecord::Migration
  def change
    add_column :bids, :completed_at, :datetime
  end
end
