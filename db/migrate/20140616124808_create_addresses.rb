class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :city
      t.string :state
      t.string :zip
      t.string :addressable_type

      t.integer :addressable_id

      t.timestamps
    end
  end
end
