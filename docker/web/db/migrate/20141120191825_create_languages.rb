class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
    	t.string :name
    	t.references :languageable, polymorphic: true
    end
  end
end
