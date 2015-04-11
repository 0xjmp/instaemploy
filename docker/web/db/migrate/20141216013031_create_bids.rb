class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.belongs_to :project
      t.belongs_to :user
      t.float :price
      t.string :state, default: 'incomplete', null: false
      t.timestamps
    end
  end
end
