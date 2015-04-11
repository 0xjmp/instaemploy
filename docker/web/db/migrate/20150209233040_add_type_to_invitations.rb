class AddTypeToInvitations < ActiveRecord::Migration
  def change
    change_table :invitations do |t|
      t.string :type, default: "", null: false
    end
  end
end
