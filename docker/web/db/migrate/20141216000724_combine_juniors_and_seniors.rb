class CombineJuniorsAndSeniors < ActiveRecord::Migration
  def change
    drop_table :juniors
    rename_table :seniors, :users
    change_table :users do |t|
      t.boolean :senior, default: false, null: false
    end
  end
end
