module Importers
  module Orders
    class Mapping
      def initialize
        @customer_cache = nil
      end

      def get_mapper(_strategy_class)
        Topographer::Importer.build_mapper(::Order) do |mapper|
          mapper.required_mapping('Order Number', 'order_number')
          mapper.required_mapping('Order Date', 'ordered_at')
          mapper.required_mapping('Customer Email', 'customer') do |input_data|
            email_address = input_data['Customer Email']
            @customer_cache = Customer.find_by(email: email_address)
            fail "Unable to find customer with email: #{email_address}" unless @customer_cache
            @customer_cache
          end
          shipping_fields = ['Shipping Street', 'Shipping City', 'Shipping State', 'Shipping Zip']
          mapper.validation_field('Shipping Address Check', shipping_fields) do |input_data|
            new_address = Address.new(
              street: input_data['Shipping Street'],
              city: input_data['Shipping City'],
              state: input_data['Shipping State'],
              zip: input_data['Shipping Zip']
            )
            valid = @customer_cache.primary_shipping_address == new_address ||
              @customer_cache.secondary_shipping_address == new_address
            fail "Invalid shipping address for #{@customer_cache.email}" unless valid
          end
        end
      end
    end
  end
end
