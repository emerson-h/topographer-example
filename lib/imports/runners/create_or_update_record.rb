module Imports
  module Runners
    class CreateOrUpdateRecord
      include Imports::Runners::Base

      def initialize(file, import_class,  options={})
        setup_runner(file, 'create_or_update_record', options)
        @strategy_class = Imports::Strategy::CreateOrUpdateRecord
        @import_class = import_class
      end
    end
  end
end
