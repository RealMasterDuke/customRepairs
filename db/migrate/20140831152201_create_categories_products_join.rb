class CreateCategoriesProductsJoin < ActiveRecord::Migration
  def change
    create_table :categories_products_joins do |t|
    end
  end

  def self.up
    create_table 'categories_products', :id => false do |t|
      t.column 'category_id', :integer
      t.column 'product_id', :integer
    end
  end

  def self.down
   drop_table 'categories_products'
  end

end
