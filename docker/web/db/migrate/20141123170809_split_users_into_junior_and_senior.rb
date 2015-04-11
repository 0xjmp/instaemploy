class SplitUsersIntoJuniorAndSenior < ActiveRecord::Migration
  def up
  	change_table :users do |t|
  		t.references :userable, polymorphic: true
  	end

  	create_table :juniors do |t|
  	end
  	
  	create_table :seniors do |t|
  	end
  end
end