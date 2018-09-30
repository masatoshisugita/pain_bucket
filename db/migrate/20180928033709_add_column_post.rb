class AddColumnPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :initial_symptom, :text

  end
end
