require_relative 'method_data'
require_relative 'attribute_data'

#TODO: COMMENTS
module Languages

  CLASS_TOKEN = 1
  ATTRIBUTE_TOKEN = 2
  DEF_TOKEN = 3
  VISIBILITY_TOKEN = 4
  END_TOKEN = 5
 
  #TODO: COMMENTS
  class RubySyntaxSupport
    attr_reader :token
    @class_token

    def initialize
      @token = @class_token = 0
    end
     
    def increment_token
      @token = @token + 1
    end

    def decrement_token
      if @token >= 0
        @token = @token - 1
      else
        #TODO: Handle it soon!
      end
    end

    def has_class?(line)
      return regex_match(line, /\bclass\b\b[ |\t]+\s*(.*)\b/)
    end

    def get_class_name(line)
      return line.scan(/\bclass\b\b[ |\t]+\s*(.*)\b/)[0][0]
    end

    def has_attribute?(line)
      #TODO
      return regex_match(line,/(@|attr_accessor|attr_read|attr_write)([^:].*)/)
    end

    def get_attribute(line)
      name = line.scan(/(@|attr_accessor|attr_read|attr_write)([^:].*)/)[0][0]
      attribute = AttributeData.new(name)
      return attribute
    end

    def has_method?(line)
      return regex_match(line, /\bdef\b\b[ |\t]+\s*(.*)\b/)
    end

    def get_method(line)
      methodName = line.scan(/\bdef\b\b[ |\t]+\s*(.*)\b/)[0]
      method = MethodData.new(methodName)
      return method
    end

    def has_end?(line)
      #TODO
      return regex_match(line, /end/)
    end

    def has_visibility?(line)
      #TODO
      return regex_match(line, /private|public|protected/)
    end

    def get_visibiliy(line)
      return line.scan(/private|public|protected/)[0]
    end 

    def get_token_type(line)
      if has_class?(line)
        increment_token
        @class_token = token
        return CLASS_TOKEN
      end
      
      # Has class token?
      if has_token_class?
        if has_attribute?(line)
          return ATTRIBUTE_TOKEN
        elsif has_method?(line)
          return DEF_TOKEN
        elsif has_end?(line)
          decrement_token
          return END_TOKEN
        elsif has_visibility?(line)
          return VISIBILITY_TOKEN
        end
      end
      #elsif has_def? ... it means global function
    end

  private
    def regex_match(value, regex)
      if value =~ regex
        return true
      end
      return false
    end

    def has_token_class?
      if @class_token > 0
        return true
      end
      return false
    end

  #end of class 
  end
#end of module
end
