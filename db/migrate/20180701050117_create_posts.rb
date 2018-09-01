class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|

      t.string :name
      t.integer :user_id
      t.string :sick_name
      t.string :period
      t.text :content

      t.timestamps
    end
  end
end
