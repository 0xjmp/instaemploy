class CreateFollowable < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.references :followable, polymorphic: true, index: true
    end
  end
end
