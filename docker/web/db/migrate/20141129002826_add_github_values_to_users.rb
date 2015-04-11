class AddGithubValuesToUsers < ActiveRecord::Migration
  def change
  	change_table :users do |t|
  		t.string :avatar
  		t.string :github_profile_url 
  		t.string :company
  		t.string :location
  		t.boolean :hireable
  	end
  end
end
