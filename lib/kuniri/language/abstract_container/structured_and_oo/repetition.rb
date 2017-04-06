#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

module Languages

  # @abstract Repetition class handling repetition structures.
  class Repetition
    # Get conditional.
    # @param pLine String with possible repetition statement.
    # @return Return an ConditionalData, otherwise return nil.
    def get_repetition(_pLine)
      raise NotImplementedError
    end

    protected

    # Try to detect possible repetition in the line.
    # @param pLine String with possible repetition event.
    # @return Return a partial string, otherwise return nil.
    def detect_repetition(_pLine)
      raise NotImplementedError
    end

    # Handling string type
    # @param pString String for find the repetition type.
    # @return Return a string with the type.
    def repetition_type(_pString)
      raise NotImplementedError
    end

    # Try to extract the expression.
    # @param pString String with conditional expression.
    # @param pType Loop type.
    # @return Return a partial string.
    def get_expression(_pType, _pString)
      raise NotImplementedError
    end

    # Take an partial result of string, and remove unnecessary informations.
    # @param pString Line with string.
    # @return Return a string without any unnecessary information.
    def remove_unnecessary_information(_pString)
      raise NotImplementedError
    end
  end # class
end # Languages
