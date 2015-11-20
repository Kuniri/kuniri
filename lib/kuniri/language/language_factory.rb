require_relative 'csharp/csharp_syntax'
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

      if pType == 'csharp'
        return Languages::CsharpSyntax.new
      end
      if pType == "ruby"
        return Languages::RubySyntax.new
      end
      if pType == "python"
        raise Error::LanguageError
      end
      if pType == "vhdl"
        raise Error::LanguageError
      end
      if pType == "c"
        raise Error::LanguageError
      end
      if pType == "cplusplus"
        raise Error::LanguageError
      end
      if pType == "java"
        raise Error::LanguageError
      end
      if pType == "assemblyarm"
        raise Error::LanguageError
      end
      if pType == "php"
        raise Error::LanguageError
      else
        raise Error::LanguageError
      end
    end

  # Class
  end

# Module
end
