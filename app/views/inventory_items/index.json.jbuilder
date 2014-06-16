json.array!(@inventory_items) do |inventory_item|
  json.extract! inventory_item, :id, :name, :description, :quantity, :unit_price, :enabled, :sku_code
  json.url inventory_item_url(inventory_item, format: :json)
end
