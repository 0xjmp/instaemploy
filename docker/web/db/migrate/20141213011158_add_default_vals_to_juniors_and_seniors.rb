class AddDefaultValsToJuniorsAndSeniors < ActiveRecord::Migration
  def change
    for table in [:juniors, :seniors]
      change_table table do |t|
        t.string :first_name
        t.string :last_name
        t.string :github_profile_url
        t.string :company
        t.string :location
        t.boolean :hireable, default: false, null: false
        t.string :avatar
        t.boolean :avatar_processing, default: false, null: false
        t.string :avatar_tmp
      end
    end
  end
end
