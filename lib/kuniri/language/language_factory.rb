#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

require_relative 'language'
require_relative 'ruby/ruby_syntax'
require_relative '../error/language_error'

module Languages

  # Simple factory to create language objects.
  class LanguageFactory

    # Handling the class creation.
    # @param pType [String] Type of object
    # @return Return an object of language.
    def get_language(pType)
      pType.downcase!
      return Languages::RubySyntax.new if pType == 'ruby'
      # if pType == "python"
      #   raise Error::LanguageError
      # end
      # if pType == "vhdl"
      #   raise Error::LanguageError
      # end
      # if pType == "c"
      #   raise Error::LanguageError
      # end
      # if pType == "cplusplus"
      #   raise Error::LanguageError
      # end
      # if pType == "java"
      #   raise Error::LanguageError
      # end
      # if pType == "assemblyarm"
      #   raise Error::LanguageError
      # end
      # if pType == "php"
      #   raise Error::LanguageError

      raise Error::LanguageError
    end
  end # Class
end # Module
