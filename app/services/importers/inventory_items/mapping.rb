module Importers
  module InventoryItems
    class Mapping
      def get_mapper(_strategy_class)
        Topographer::Importer.build_mapper(::InventoryItem) do |mapper|
          mapper.required_mapping('Name', 'name')
          mapper.required_mapping('SKU Code', 'sku_code') do |inputs|
            inputs['SKU Code'].upcase
          end
          mapper.required_mapping('Description', 'description')
          mapper.required_mapping('Quantity', 'quantity')
          mapper.required_mapping('Unit Price', 'unit_price')
        end
      end
    end
  end
end
