module Importers
  module Customers
    class Mapping
      def get_mapper(_strategy)
        Topographer::Importer.build_mapper(::Customer) do |mapper|
          mapper.required_mapping('Name', 'name')
          mapper.required_mapping('Email', 'email')
          mapper.required_mapping(
            ['Billing Street',
              'Billing City',
              'Billing State',
              'Billing Zipcode'],
            'billing_address'
          ) do |inputs|
            Address.create!(
              street: inputs['Billing Street'],
              city: inputs['Billing City'],
              state: inputs['Billing State'],
              zip: inputs['Billing Zipcode'],
            )
          end
          mapper.required_mapping(
            ['Primary Shipping Street',
              'Primary Shipping City',
              'Primary Shipping State',
              'Primary Shipping Zipcode'],
            'primary_shipping_address'
          ) do |inputs|
            Address.create!(
              street: inputs['Primary Shipping Street'],
              city: inputs['Primary Shipping City'],
              state: inputs['Primary Shipping State'],
              zip: inputs['Primary Shipping Zipcode'],
            )
          end
          mapper.optional_mapping(
            ['Secondary Shipping Street',
              'Secondary Shipping City',
              'Secondary Shipping State',
              'Secondary Shipping Zipcode'],
            'secondary_shipping_address'
          ) do |inputs|
            has_all_input = inputs.values.none?(&:blank?)
            if has_all_input
              Address.create!(
                street: inputs['Secondary Shipping Street'],
                city: inputs['Secondary Shipping City'],
                state: inputs['Secondary Shipping State'],
                zip: inputs['Secondary Shipping Zipcode'],
              )
            end
          end
        end
      end
    end
  end
end
