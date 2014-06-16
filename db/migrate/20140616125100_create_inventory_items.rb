class CreateInventoryItems < ActiveRecord::Migration
  def change
    create_table :inventory_items do |t|
      t.string :name
      t.text :description
      t.integer :quantity
      t.float :unit_price
      t.boolean :enabled, default: true, nullable: false
      t.string :sku_code

      t.timestamps
    end
  end
end
