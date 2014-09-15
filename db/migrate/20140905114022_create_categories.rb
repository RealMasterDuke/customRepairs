class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :title
      t.text :text
      t.string :image

      t.timestamps
    end
  end
end
