module Imports
  module Mappings
    class Customer
      extend Topographer::Importer::Importable
      include Topographer::Importer::Helpers
      include Imports::Mappings::Base

      def self.get_mapper(strategy_class)
        mapping = new
        case

          when strategy_class == Imports::Strategy::ImportNewRecord
            mapping.import_new_record
          when strategy_class == Imports::Strategy::UpdateRecord
            mapping.update_record
          when strategy_class == Imports::Strategy::CreateOrUpdateRecord
            mapping.create_or_update_record
          else
            raise "Unsupported import strategy: #{strategy_class}"
        end
      end
      # Map fields with the following syntax
      #
      # mapper.required_mapping('Input Column', 'output_field') for required mappings
      # mapper.optional_mapping('Input Column', 'output_field') for optional mappings
      # The above mappings can take an optional behavior block that can be used to transform the value being mapped.
      # When a block is provided, its return value will be the value mapped to the output field.
      #
      # mapper.validation_field('Unique Validation Name', 'Input Column') { <validation block> } for a validation only mapping
      # mapper.ignored_column('Column to ignore') to ignore a column
      # mapper.default_value('output field for default') { <default_value> } to give an output field a default value
      # mapper.key_field('output_field_name') to make a field available as a search key in strategies
      #
      # Model fields are:

      #   id
      #   name
      #   email
      #   created_at
      #   updated_at


      def import_new_record
        Topographer::Importer.build_mapper(::Customer) do |mapper|
          #Add your field mappings here using the above syntax
        end
        # Remove this line to activate this mapping
        raise NotImplementedError
      end

      def update_record
        Topographer::Importer.build_mapper(::Customer) do |mapper|
          #Add your field mappings here using the above syntax
        end
        # Remove this line to activate this mapping
        raise NotImplementedError
      end

      def create_or_update_record
        Topographer::Importer.build_mapper(::Customer) do |mapper|
          #Add your field mappings here using the above syntax
        end
        # Remove this line to activate this mapping
        raise NotImplementedError
      end


      def self.importable_columns
        {

          'Id' => 'id',
          'Name' => 'name',
          'Email' => 'email',
          'Created at' => 'created_at',
          'Updated at' => 'updated_at',
        }
      end
    end
  end
end
