#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

module Languages

  # @abstract This class is responsible for handling elements whose the
  # behaviour is similar to a function. For example, method and global
  # function has a very similar behaviour, because of this is a good idea
  # to use this class as parent.
  class FunctionBehavior
    # Verify if line has a potential function.
    # @param pLine String with potencial function.
    # @return Returns FuntionData, or nil if line doesn't have method.
    def get_function(_pLine, _type = 'globalFunction')
      raise NotImplementedError
    end

    protected

    # Detect function in line.
    # @param pLine Line string with the potential method inside.
    # @return Return the method if it is find in the string, othewise return
    #   nil.
    def detect_function(_pLine)
      raise NotImplementedError
    end

    # Remove unnecessary information inside the string.
    # @param pLine Line for handling the string.
    # @return Return a string.
    def remove_unnecessary_information(_pLine)
      raise NotImplementedError
    end

    # Handling default parameters.
    # @param pLine Line to be check.
    # @return Return a string.
    def handling_default_parameter(_pLine)
      raise NotImplementedError
    end

    # Handling parameters.
    # @param pLine String to try to find the parameters.
    # @return Return a list with all the parameter, othewise return nil
    def handling_parameter(_pLine)
      raise NotImplementedError
    end
  end # Class
end # Languages
