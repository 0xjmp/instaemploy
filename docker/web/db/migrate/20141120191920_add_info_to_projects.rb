class AddInfoToProjects < ActiveRecord::Migration
  def change
  	change_table :projects do |t|
  		t.datetime :due_date
  		t.boolean :is_available
  		t.timestamps
  	end
  end
end
