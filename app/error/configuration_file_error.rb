# Error module, responsible for manage the errors.
module Error
  # Configuration_file_error is a class responsable for handling the many 
  # different kind of error that can be raised in case of syntax error.
  class Configuration_file_error < RuntimeError
  end
end
