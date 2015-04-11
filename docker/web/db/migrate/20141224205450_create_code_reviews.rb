class CreateCodeReviews < ActiveRecord::Migration
  def change
    create_table :code_reviews do |t|
      t.boolean :pending, null: false, default: true
      t.string :title
      t.text :markdown
      t.string :language
      t.belongs_to :bid
      t.timestamps
    end
    create_table :code_reviews_users, id: false do |t|
      t.belongs_to :user, index: true
      t.belongs_to :code_review, index: true
    end
  end
end
