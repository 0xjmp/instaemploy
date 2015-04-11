class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :code
      t.references :invitable, polymorphic: true
      t.string :email
    end

    add_index :invitations, :code, unique: true
    add_index :invitations, :email, unique: true
  end
end
