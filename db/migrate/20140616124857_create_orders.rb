class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :order_number
      t.datetime :ordered_at
      t.boolean :on_hold, default: false, nullable: false

      t.integer :customer_id

      t.timestamps
    end
  end
end
