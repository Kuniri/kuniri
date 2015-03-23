require_relative 'attribute_ruby'
require_relative 'method_ruby'
require_relative 'token_ruby'
require_relative 'class_ruby'
require_relative 'constructor_ruby'
require_relative 'extern_requirement_ruby'
require_relative 'function_global_ruby'
require_relative '../container_data/structured_and_oo/method_data'
require_relative '../container_data/structured_and_oo/attribute_data'
require_relative '../container_data/structured_and_oo/constructor_data'

module Languages

  # This class implements useful methods for help to handling Ruby syntax.
  class RubySyntaxSupport

    def initialize
      @attributeRuby = Languages::Ruby::AttributeRuby.new
      @methodRuby = Languages::Ruby::MethodRuby.new
      @classRuby = Languages::Ruby::ClassRuby.new
      @externRequirement = Languages::Ruby::ExternRequirementRuby.new
      @functionGlobalRuby = Languages::Ruby::FunctionGlobalRuby.new
      @constructorRuby = Languages::Ruby::ConstructorRuby.new
    end

    def apply_regex(line, regex)
      result = line.scan(regex)[0]

      return nil unless result
      return result
    end

    def get_class_name(line)
      return @classRuby.get_class(line)
    end

    def get_attribute(line)
      # TODO: THE CORRECT IS ONLY:return @attributeRuby.get_attribute(line)
      listAttribute =  @attributeRuby.get_attribute(line)
      listReturn = []
      listAttribute.each do |element|
        listReturn.push(element.name)
      end

      return listReturn
    end

    def get_function(pLine)
      return @functionGlobalRuby.get_function(pLine)
    end

    def get_method(line)
      return @methodRuby.get_method(line)
    end

    def get_constructor(line)
      return @constructorRuby.get_constructor(line)
    end

    def get_extern_requirement(pLine)
      return @externRequirement.get_requirement(pLine)
    end

    def get_begin(line)
      regexExpression = /^\s+begin|^begin/
      return apply_regex(line, regexExpression)
    end

    def get_case(line)
      regexExpression = /^\s+case|^case/
      return apply_regex(line, regexExpression)
    end

    def get_do(line)
      regexExpression = /\s+do\s+|^do\s+|\s+do/
      return apply_regex(line, regexExpression)
    end

    def get_if(line)
      regexExpression = /^\s+if|^if/
      return apply_regex(line, regexExpression)
    end

    def get_module(line)
      regexExpression = /^\s+module|^module/
      return apply_regex(line, regexExpression)
    end

    def get_unless(line)
      regexExpression = /^\s+unless|^unless/
      return apply_regex(line, regexExpression)
    end

    def has_end?(line)
      return true if line =~ /^\s+end|^end/
      return false
    end

    def get_visibiliy(line)
      regexExpression = /private|public|protected/
      return apply_regex(line, regexExpression)
    end

    def get_token_type(line, class_token=false)
      # Special token for class
      if class_token
        if @attributeRuby.get_attribute(line)
          return Ruby::ATTRIBUTE_TOKEN 
        elsif get_visibiliy(line)
          return Ruby::VISIBILITY_TOKEN
        end
      end

      # All of these reserved words are close with "end"
      if @classRuby.get_class(line)
        return Ruby::CLASS_TOKEN
      elsif has_end?(line)
        return Ruby::END_TOKEN
      elsif get_begin(line)
        return Ruby::BEGIN_TOKEN
      elsif @methodRuby.get_method(line)
        return Ruby::DEF_TOKEN
      elsif get_case(line)
        return Ruby::CASE_TOKEN
      elsif get_do(line)
        return Ruby::DO_TOKEN
      elsif get_if(line)
        return Ruby::IF_TOKEN
      elsif get_module(line)
        return Ruby::MODULE_TOKEN
      elsif get_unless(line)
        return Ruby::UNLESS_TOKEN
      end

      # Other reserved words
      if @externRequirement.get_requirement(line)
        return Ruby::REQUIRE_TOKEN
      #elsif ...
      end
    end

  #end of class
  end

#end of module
end
