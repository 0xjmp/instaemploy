class AddViewsToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :views, :integer, default: 0, null: false
  end
end
