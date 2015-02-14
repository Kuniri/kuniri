#reference: 
# http://www.java2s.com/Code/Ruby/Language-Basics/Rubysreservedwords.htm
require_relative 'method_data'
require_relative 'attribute_data'

module Languages

  # Token types used to identify keywords
  CLASS_TOKEN = 1 # Executes the block passed to the method.
  ATTRIBUTE_TOKEN = 2
  DEF_TOKEN = 3
  VISIBILITY_TOKEN = 4
  END_TOKEN = 5 # Code, enclosed in { and }, to run when the program ends.
  IF_TOKEN = 6 # Executes code block if true. Closes with end.
  WHILE_TOKEN = 7 # Executes the block passed to the method.
  DO_TOKEN = 8 # Begins a block and executes code in that block(end)
  BEGIN_TOKEN = 9 # Code, enclosed in { and }, to run before the program runs.
  ALIAS_TOKEN = 10 # Creates an alias: method, operator, or global variable.
  AND_TOKEN = 11 # Logical operator same as && except and has lower precedence.
  BEGIN_DOWN_TOKEN = 12 # Begins a code block or group of statements (end).
  BREAK_TOKEN = 13 # Terminates a while or until loop or a method.
  CASE_TOKEN = 14 # Compares an expression with a matching when clause (end).
# LOST NUMBER 15, ADD NEW KEYWORD HERE.
  DEFINED_TOKEN = 16 # Determines: variable, method, super method, or block.
  ELSE_TOKEN = 17 # Executes if previous conditional.
  ELSIF_TOKEN = 18 # Executes if previous conditional, in if or elsif.
  ENSURE_TOKEN = 19 # Always executes at block termination.
  FALSE_TOKEN = 20 # Logical or Boolean false, instance of FalseClass.
  TRUE_TOKEN = 21 # Instance of TrueClass.
  FOR_TOKEN = 22 # Begins a for loop; used with in.
  MODULE_TOKEN = 23 # Defines a module; closes with end.
  NEXT_TOKEN = 24 # Jumps before a loop's conditional.
  NIL_TOKEN = 25 # Object of NilClass.
  NOT_TOKEN = 26 # Logical operator, same as !.
  OR_TOKEN = 27 # Logical operator, same as ||.
  REDO_TOKEN = 28 # Jumps after a loop's conditional.
  RESCUE_TOKEN = 29 # Evaluates an expression after an exception is raised.
  RETRY_TOKEN = 30 # Repeats a method call outside of rescue.
  RETURN_TOKEN = 31 # Returns a value from a method or block.
  SELF_TOKEN = 32 # Current object (invoked by a method).
  SUPER_TOKEN = 33 # Calls method of the same name in the superclass.
  THEN_TOKEN = 34 # A continuation for if, unless, and when.
  UNDEF_TOKEN = 35 # Makes a method in current class undefined.
  UNLESS_TOKEN = 36 # Executes code block if conditional statement is false.
  UNTIL_TOKEN = 37 # Executes code block while conditional statement is false.
  WHEN_TOKEN = 38 # Starts a clause (one or more) under case.
  YIELD_TOKEN = 39 # Executes the block passed to the method.

  # This class implements useful methods for help to handling Ruby syntax.
  class RubySyntaxSupport

    def apply_regex(line, regex)
      result = line.scan(regex)[0]
      if not result
        return nil
      end
      return result
    end

    # Verify if line has the keyword and return it, otherwise return nil
    # @param line String to apply the regex
    # @return Return nil if anything is find, or the class name
    def get_class_name(line)
      regexExpression = /^\s*class\b[ |\t]+\s*(.*)\b/
      return apply_regex(line, regexExpression)
    end

    # Verify if a line has an attribute. If it has attribute, first the 
    # function capture all lines and remove "@" or ":" and whitespace, finally
    # it splits the string by "," and return an array. Otherwise it returns 
    # nil.
    # @param line to inpect for find attribute.
    # @return Return nil if not find attribute or an array with the attribute.
    def get_attribute(line)
      regexExp = /^\s*(?:@|attr_(?:accessor|read|write))(.*)$/
      variables = apply_regex(line, regexExp)
      if not variables
        return nil
      end
      variables = variables.join("")
      variables.gsub!(/\s+|:|@/,"")
      return variables.split(",")
    end

    def get_method(line)
      regexExpression = /^\s*def\b\s*(\w*)\b/
      return apply_regex(line, regexExpression)
    end

    def get_begin(line)
      # TODO: IMPROVE THE REGEX
      regexExpression = /begin/
      return apply_regex(line, regexExpression)
    end

    def get_case(line)
      # TODO: IMPROVE THE REGEX
      regexExpression = /case/
      return apply_regex(line, regexExpression)
    end

    def get_do(line)
      # TODO: IMPROVE THE REGEX
      regexExpression = /do/
      return apply_regex(line, regexExpression)
    end

    def get_if(line)
      # TODO: IMPROVE THE REGEX
      regexExpression = /if/
      return apply_regex(line, regexExpression)
    end

    def get_module(line)
      # TODO: IMPROVE THE REGEX
      regexExpression = /module/
      return apply_regex(line, regexExpression)
    end

    def get_unless(line)
      # TODO: IMPROVE THE REGEX
      regexExpression = /unless/
      return apply_regex(line, regexExpression)
    end

    def has_end?(line)
      if line =~ /end/
        return true
      end
      return false
    end

    def get_visibiliy(line)
      regexExpression = /private|public|protected/
      return apply_regex(line, regexExpression)
    end

    def get_token_type(line, class_token=false)
      # Special token for class
      if class_token
        if get_attribute(line)
          return ATTRIBUTE_TOKEN 
        elsif get_visibiliy(line)
          return VISIBILITY_TOKEN
        end
      end

      # All of these reserved words are close with "end"
      if get_class_name(line)
        return CLASS_TOKEN
      elsif has_end?(line)
        return END_TOKEN
      elsif get_begin(line)
        return BEGIN_TOKEN
      elsif get_method(line)
        return DEF_TOKEN
      elsif get_case(line)
        return CASE_TOKEN
      elsif get_do(line)
        return DO_TOKEN
      elsif get_if(line)
        return IF_TOKEN
      elsif get_module(line)
        return MODULE_TOKEN
      elsif get_unless(line)
        return UNLESS_TOKEN
      end

      # Other reserved words
    end
  #end of class 
  end
#end of module
end
