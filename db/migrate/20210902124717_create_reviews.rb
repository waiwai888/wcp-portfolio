class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.text :body, null: false
      t.integer :site_id, null: false
      t.float :score, default: 0, null: false 

      t.timestamps
    end
  end
end
