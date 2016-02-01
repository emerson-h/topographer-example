module Importers
  module Orders
    class Strategy < Topographer::Importer::Strategy::ImportNewRecord
      def initialize
      end

      def import_record(source_data)
        mapping_result = mapper.map_input(source_data)
        order = mapper.model_class.new(mapping_result.data)
        order.valid?
        model_errors = order.errors.full_messages

        status = get_import_status(mapping_result, model_errors)

        if should_persist_import?(status)
          json = get_order_items_json(order.order_number)
          json['items'].each do |item_json|
            inventory_item = InventoryItem.find_by(sku_code: item_json['item_sku'])
            if inventory_item
              order.order_items.build(
                quantity: item_json['quantity'],
                discount: item_json['discount'],
                inventory_item: inventory_item
              )
            else
              status.add_error(:mapping, "Unable to find item with SKU #{item_json['item_sku']}")
            end
          end
        end

        order.save if should_persist_import?(status)

        status
      end

      private def get_order_items_json(order_id)
        connection = Faraday.new(url: 'http://api.example.com') do |faraday_connection|
          faraday_connection.request :url_encoded             # form-encode POST params
          faraday_connection.port = 80
          faraday_connection.headers['Content-Type'] = 'application/json'
          faraday_connection.response :logger                  # log requests to STDOUT
          faraday_connection.adapter Faraday.default_adapter  # make requests with Net::HTTP
        end
        response = connection.get("/orders/#{order_id}")
        JSON.parse(response.body)
      end
    end
  end
end


