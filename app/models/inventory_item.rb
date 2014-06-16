class InventoryItem < ActiveRecord::Base

  validates :name, presence: true
  validates :sku_code, presence: true
  validates :description, presence: true
  validates :quantity, presence: true
  validates :quantity, numericality: { only_integer: true}
  validates :unit_price, presence: true
  validates :unit_price, numericality: { greater_than_or_equal_to: 0 }

  has_many :order_items
end
