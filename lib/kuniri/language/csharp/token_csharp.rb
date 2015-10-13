module Languages

  module Csharp

    # Token types used to identify keywords
    CLASS_TOKEN      ||= 1 # Executes the block passed to the method.
    ATTRIBUTE_TOKEN  ||= 2
    DEF_TOKEN        ||= 3
    VISIBILITY_TOKEN ||= 4
    END_TOKEN        ||= 5 # Code, enclosed in { and }, to run when the program ends.
    IF_TOKEN         ||= 6 # Executes code block if true. Closes with end.
    WHILE_TOKEN      ||= 7 # Executes the block passed to the method.
    DO_TOKEN         ||= 8 # Begins a block and executes code in that block(end)
    BEGIN_TOKEN      ||= 9 # Code, enclosed in { and }, to run before the program runs.
    ALIAS_TOKEN      ||= 10 # Creates an alias: method, operator, or global variable.
    AND_TOKEN        ||= 11 # Logical operator same as && except and has lower precedence.
    BEGIN_DOWN_TOKEN ||= 12 # Begins a code block or group of statements (end).
    BREAK_TOKEN      ||= 13 # Terminates a while or until loop or a method.
    CASE_TOKEN       ||= 14 # Compares an expression with a matching when clause (end).
    REQUIRE_TOKEN    ||= 15 # Extern requirement
    DEFINED_TOKEN    ||= 16 # Determines: variable, method, super method, or block.
    ELSE_TOKEN       ||= 17 # Executes if previous conditional.
    ELSIF_TOKEN      ||= 18 # Executes if previous conditional, in if or elsif.
    ENSURE_TOKEN     ||= 19 # Always executes at block termination.
    FALSE_TOKEN      ||= 20 # Logical or Boolean false, instance of FalseClass.
    TRUE_TOKEN       ||= 21 # Instance of TrueClass.
    FOR_TOKEN        ||= 22 # Begins a for loop; used with in.
    MODULE_TOKEN     ||= 23 # Defines a module; closes with end.
    NEXT_TOKEN       ||= 24 # Jumps before a loop's conditional.
    NIL_TOKEN        ||= 25 # Object of NilClass.
    NOT_TOKEN        ||= 26 # Logical operator, same as !.
    OR_TOKEN         ||= 27 # Logical operator, same as ||.
    REDO_TOKEN       ||= 28 # Jumps after a loop's conditional.
    RESCUE_TOKEN     ||= 29 # Evaluates an expression after an exception is raised.
    RETRY_TOKEN      ||= 30 # Repeats a method call outside of rescue.
    RETURN_TOKEN     ||= 31 # Returns a value from a method or block.
    SELF_TOKEN       ||= 32 # Current object (invoked by a method).
    SUPER_TOKEN      ||= 33 # Calls method of the same name in the superclass.
    THEN_TOKEN       ||= 34 # A continuation for if, unless, and when.
    UNDEF_TOKEN      ||= 35 # Makes a method in current class undefined.
    UNLESS_TOKEN     ||= 36 # Executes code block if conditional statement is false.
    UNTIL_TOKEN      ||= 37 # Executes code block while conditional statement is false.
    WHEN_TOKEN       ||= 38 # Starts a clause (one or more) under case.
    YIELD_TOKEN      ||= 39 # Executes the block passed to the method.
    INTEGER_TOKEN    ||= 40
    ARRAY_TOKEN      ||= 41
    HASH_TOKEN       ||= 42
    OBJECT_TOKEN     ||= 43
    CONSTRUCTOR_TOKEN ||= 44

    # Module
  end

# Language
end
