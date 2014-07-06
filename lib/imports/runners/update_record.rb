module Imports
  module Runners
    class UpdateRecord
      include Imports::Runners::Base

      def initialize(file, import_class,  options={})
        setup_runner(file, 'update_record', options)
        @strategy_class = Imports::Strategy::UpdateRecord
        @import_class = import_class
      end
    end
  end
end
