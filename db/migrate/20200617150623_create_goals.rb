class CreateGoals < ActiveRecord::Migration[6.0]
  def change
    create_table :goals do |t|
      t.integer :user_id
      t.integer :category_id
      t.string :name
      t.boolean :completed, default: false
      t.string :details

      t.timestamps
    end
  end
end
