class CreateJobs < ActiveRecord::Migration
  def change
    create_table :projects do |t|
    	t.string :title
    	t.string :description
    	t.string :repo_url, unique: true
    	t.belongs_to :user
    end
  end
end
