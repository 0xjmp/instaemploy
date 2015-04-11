class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.string :email, null: false
    end

    add_index :alerts, :email, unique: true
  end
end
