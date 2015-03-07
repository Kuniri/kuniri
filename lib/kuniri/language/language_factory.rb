require_relative 'language'
require_relative 'ruby/ruby_syntax'

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
        #return Languages::PythonSyntax.new
      elsif pType == "vhdl"
        #return Languages::VhdlSyntax.new
      elsif pType == "c"
        #return Languages::CSyntax.new
      elsif pType == "cplusplus"
        #return Languages::CplusPlusSyntax.new
      elsif pType == "java"
        #return Languages::JavaSyntax.new
      elsif pType == "assemblyarm"
        #return Languages::AssemblyArm.new
      else
        raise
      end
    end

  # Class
  end

# Module
end
