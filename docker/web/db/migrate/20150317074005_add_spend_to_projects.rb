class AddSpendToProjects < ActiveRecord::Migration
  def change
    change_table :projects do |t|
      t.float :spend, null: false, default: 0.00
    end
  end
end
