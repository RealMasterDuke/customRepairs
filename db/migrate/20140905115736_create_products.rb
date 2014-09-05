class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.text :text
      t.integer :category_id
      t.string :image
      t.decimal :price

      t.timestamps
    end
  end
end
