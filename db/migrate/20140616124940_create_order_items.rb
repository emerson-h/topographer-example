class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.float :discount
      t.integer :order_id
      t.integer :inventory_item_id

      t.timestamps
    end
  end
end
