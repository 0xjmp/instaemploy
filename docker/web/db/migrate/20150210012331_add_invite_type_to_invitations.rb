class AddInviteTypeToInvitations < ActiveRecord::Migration
  def change
    change_table :invitations do |t|
      t.string :invite_type
    end
  end
end
