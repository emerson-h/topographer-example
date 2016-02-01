module Importers
  class InventoryItem
    def initialize(file)
      @logger = Topographer::Importer::Logger::Simple.new
      setup_input(file)
    end

    def import
      return false unless @logger.success?
      ActiveRecord::Base.transaction do
        mapping = Importers::InventoryItems::Mapping.new
        Topographer::Importer.import_data(
          @input,
          mapping,
          Topographer::Importer::Strategy::ImportNewRecord.new(mapping),
          @logger
        )
        fail ActiveRecord::Rollback unless @logger.success?
      end
      @logger.success?
    end

    def errors
      @logger.failures + @logger.fatal_errors
    end

    private def setup_input(file)
      begin
        spreadsheet = Roo::Excelx.new(file, untyped: true)
        data_sheet = spreadsheet.sheet('Sheet1')
        header_row = 1
        data_start_row = 2
        @input = Topographer::Importer::Input::Roo.new(data_sheet, header_row, data_start_row)
      rescue StandardError
        @logger.log_fatal('File open failure', 'Unable to open files for import.')
      end
    end
  end
end
