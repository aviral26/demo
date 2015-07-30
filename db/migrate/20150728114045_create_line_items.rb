class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.integer :quantity
      t.decimal :unit_price
      t.integer :product_id
      t.timestamps null: false
    end
    add_foreign_key :line_items, :products
  end
end
