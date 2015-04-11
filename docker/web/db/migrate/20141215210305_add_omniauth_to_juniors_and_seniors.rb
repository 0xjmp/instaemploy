class AddOmniauthToJuniorsAndSeniors < ActiveRecord::Migration
  def change
    change_table :juniors do |t|
      t.string :provider
      t.string :uid
    end

    add_index :juniors, :uid, unique: true

    change_table :seniors do |t|
      t.string :provider
      t.string :uid
    end

    add_index :seniors, :uid, unique: true
  end
end
