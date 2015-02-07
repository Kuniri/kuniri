require_relative 'method_data'
require_relative 'attribute_data'

module Languages

  # Token types used to identify keywords
  CLASS_TOKEN = 1
  ATTRIBUTE_TOKEN = 2
  DEF_TOKEN = 3
  VISIBILITY_TOKEN = 4
  END_TOKEN = 5
  IF_TOKEN = 6
  WHILE_TOKEN = 7
  DO_TOKEN = 8

  # This class implements useful methods for help to handling Ruby syntax.
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

    # Verify if line has the keyword and return it, otherwise return nil
    # @param line String to apply the regex
    # @return Return nil if anything is find, or the class name
    def get_class_name(line)
      className = line.scan(/\bclass\b\b[ |\t]+\s*(.*)\b/)[0]
      if not className
        return nil
      end

      return className
    end

    def get_attribute(line)
      name = line.scan(/(@|attr_accessor|attr_read|attr_write)([^:].*)/)[0]
      if not name
        return nil
      end

      attribute = AttributeData.new(name)
      return attribute
    end

    def get_method(line)
      methodName = line.scan(/\bdef\b\b[ |\t]+\s*(.*)\b/)[0]
      if not methodName
        return nil
      end

      method = MethodData.new(methodName)
      return method
    end

    def has_end?(line)
      if line =~ /end/
        return true
      end

      return false
    end

    def get_visibiliy(line)
      visibilityName = line.scan(/private|public|protected/)[0]
      if not visibilityName
        return nil
      end

      return visibilityName
    end

    def get_token_type(line)
      if get_class_name(line)
        increment_token
        @class_token = token
        return CLASS_TOKEN
      end

      # Has class token?
      if has_token_class?
        if get_attribute(line)
          return ATTRIBUTE_TOKEN
        elsif get_method(line)
          return DEF_TOKEN
        elsif has_end?(line)
          decrement_token
          return END_TOKEN
        elsif get_visibiliy(line)
          return VISIBILITY_TOKEN
        end
      end
    end

  private

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
