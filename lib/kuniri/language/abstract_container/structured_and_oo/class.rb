#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

module Languages

  # @abstract Class is an container for handling class
  class Class
    # Inspect line, and verify if it has a class or not.
    # @param pLine Line with the potential class.
    # @return Return an object ClassData if it find a class in the line,
    #         otherwise return nil.
    def get_class(_pLine)
      raise NotImplementedError
    end

    protected

    # Verify if line can have a class.
    # @param pLine Line to inspect.
    # @return Returns an row string with class name, otherwise returns nil.
    def detect_class(_pLine)
      raise NotImplementedError
    end

    # Check if class has an inheritance inside.
    # @param pString Line with the potential inheritance inside.
    # @return Returns a string with the inheritance class, or return nil.
    def get_inheritance(_pString)
      raise NotImplementedError
    end

    # Take an partial result of string, and remove unnecessary informations.
    # @param pString Line with string.
    # @return Return a string without any unnecessary information.
    def remove_unnecessary_information(_pString)
      raise NotImplementedError
    end

    # Prepare final string before save it. Here it is the place to prune the
    # final details in the string.
    # @param pString String to be improved before save it.
    # @return Returns a string prepared to be saved.
    def prepare_final_string(_pString)
      raise NotImplementedError
    end
  end # Class
end # Languages
