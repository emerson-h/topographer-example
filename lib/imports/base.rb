module Imports
  module Base
    def run_import(file, import_class, import_runner_class, options)
      import_runner_class.run(file, import_class, options)
    end
  end
end
