class OrderItem < ActiveRecord::Base

  belongs_to :order
  belongs_to :inventory_item

end
