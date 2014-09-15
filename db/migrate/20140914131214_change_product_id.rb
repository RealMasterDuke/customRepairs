class ChangeProductId < ActiveRecord::Migration

  def change

    change_table :line_items do |t|
      t.change :product_id, :integer
    end

  end

end