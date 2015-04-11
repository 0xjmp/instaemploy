class AddIsAcceptedToProjects < ActiveRecord::Migration
  def change
    change_table(:projects) do |t|
      t.boolean :is_accepted, default: false, null: false
    end
  end
end
