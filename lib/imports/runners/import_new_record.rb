module Imports
  module Runners
    class ImportNewRecord
      include Imports::Runners::Base

      def initialize(file, import_class,  options={})
        setup_runner(file, 'import_new_record', options)
        @strategy_class = Imports::Strategy::ImportNewRecord
        @import_class = import_class
      end
    end
  end
end
