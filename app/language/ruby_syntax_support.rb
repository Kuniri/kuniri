#TODO: COMMENTS
module Languages

  CLASS_TOKEN = 1
  ATTRIBUTE_TOKEN = 2
  METHOD_TOKEN = 3
  VISIBILITY_TOKEN = 4
  
  #TODO: COMMENTS
  class RubySyntaxSupport
    attr_reader :token
    @class_token

    def initialize
      @token = @class_token = 0
    end
     
    def increment_token
      @token++
    end

    def decrement_token
      if @token >= 0
        @token--
      else
        raise
      end
    end

    def has_class?(line)
      return self.regex_match(line, /\bclass\b\b[ |\t]+\s*(.*)\b/)
    end

    def has_attribute?(line)
      #TODO
      return self.regex_match(line, /@|attr_/)
    end

    def has_method?(line)
      return self.regex_match(line, /\bdef\b\b[ |\t]+\s*(.*)\b/)
    end

    def has_end?(line)
      #TODO
      return self.regex_match(line, /.../)
    end

    def has_visibility?(line)
      #TODO
      return self.regex_match(line, /private|public|protected/
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
          return METHOD_TOKEN
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
      if value ~= regex
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
