class AddProcessingToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :avatar_processing, :boolean, null: false, default: false
  	add_column :users, :avatar_tmp, :string
  end
end
