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
          # FINISH WITH "END": INCREMENT
          return DEF_TOKEN
        elsif has_end?(line)
          decrement_token
          return END_TOKEN
        elsif get_visibiliy(line)
          return VISIBILITY_TOKEN
        elsif get_begin(line)
          # FINISH WITH "END": INCREMENT
          return BEGIN_TOKEN
        elsif get_case(line)
          # FINISH WITH "END": INCREMENT
          return CASE_TOKEN
        elsif get_do(line)
          # FINISH WITH "END": INCREMENT
          return DO_TOKEN
        elsif get_if(line)
          # FINISH WITH "END": INCREMENT
          return IF_TOKEN
        elsif get_module(line)
          # FINISH WITH "END": INCREMENT
          return MODULE_TOKEN
        elsif get_unless(line)
          #  FINISH WITH "END": INCREMENT
          return UNLESS_TOKEN
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
