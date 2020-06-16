class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.float :new_price
      t.float :pre_owned_price
      t.float :stars
      t.string :image
      t.string :company_name
      t.string :rated
      t.integer :wishlist_id
      t.integer :genre_id

      t.timestamps
    end
  end
end
