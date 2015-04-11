class AddStateToProjects < ActiveRecord::Migration
  def change
    change_table(:projects) do |t|
      t.string :state, default: 'uncomplete', null: false
    end
  end
end
