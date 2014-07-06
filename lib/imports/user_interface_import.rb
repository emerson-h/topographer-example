class Imports::UserInterfaceImport
  extend Imports::Base

  def self.import_spreadsheet(upload, import_runner_class, import_class, options = {})
    file = store_upload(upload)

    logger = nil
    ActiveRecord::Base.transaction do
      logger = run_import(file, import_class, import_runner_class, options)

      if logger.errors?
        raise ActiveRecord::Rollback
      end
    end

    logger
  end

  def self.store_upload(upload, options={})
    if upload && upload.original_filename && upload.path
      input_folder = options[:input_folder] || "spreadsheet_imports"
      FileUtils.mkdir_p("inputs/#{input_folder}")
      # Store the uploaded file in case it is needed for troubleshooting.
      backup_file = File.join("inputs", input_folder, "#{Time.now.strftime('%s')}" + "#{upload.original_filename}")
      FileUtils.cp upload.path, backup_file
      backup_file
    end
  end
  private_class_method :store_upload
end
