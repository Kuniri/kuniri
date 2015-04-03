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

      if pType == "ruby"
        return Languages::RubySyntax.new
      elsif pType == "python"
        raise Error::LanguageError
      elsif pType == "vhdl"
        raise Error::LanguageError
      elsif pType == "c"
        raise Error::LanguageError
      elsif pType == "cplusplus"
        raise Error::LanguageError
      elsif pType == "java"
        raise Error::LanguageError
      elsif pType == "assemblyarm"
        raise Error::LanguageError
      elsif pType == "php"
        raise Error::LanguageError
      else
        raise Error::LanguageError
      end
    end

  # Class
  end

# Module
end
