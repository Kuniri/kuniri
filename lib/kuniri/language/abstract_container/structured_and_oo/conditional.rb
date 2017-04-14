#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

module Languages

  # @abstract Class responsible for handling conditional instructions.
  class Conditional
    # Get conditional
    # @param pLine String with possible conditional statement.
    # @return Returns an ConditionalData, otherwise return nil.
    def get_conditional(_pLine)
      raise NotImplementedError
    end

    protected

    # Try to detect possible conditional in the line.
    # @param pLine String with possible conditional event.
    # @return Return a partial string, otherwise return nil.
    def detect_conditional(_pLine)
      raise NotImplementedError
    end

    # Handling string type
    # @param pString String for find the conditional type.
    # @return Return a string with the type.
    def conditional_type(_pString)
      raise NotImplementedError
    end

    # Try to extract the expression.
    # @param pString String with conditional expression.
    # @return Return a partial string.
    def get_expression(_pString)
      raise NotImplementedError
    end

  end # class
end # Languages
