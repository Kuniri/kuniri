#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

module StateMachine

  NONE_HANDLING_STATE   ||= -1      # NONE state, just for controlling.
  GLOBAL_FUNCTION_STATE ||= 1       # Global state track.
  CONSTRUCTOR_STATE     ||= 2       # Constructor state track.
  METHOD_STATE          ||= 3       # Method state track.
  CONDITIONAL_STATE     ||= 4       # Conditional state track.
  REPETITION_STATE      ||= 5       # Repetition state track.
  BLOCK_STATE           ||= 6       # Block state track.
  SCRIPT_STATE          ||= 7       # Script state track.

  METHOD_ID             ||= 1
  CONSTRUCTOR_ID        ||= 2
  FUNCTION_ID           ||= 3
  COMMENT_ID            ||= 4
  VARIABLE_ID           ||= 5
  MODULE_ID             ||= 6
  CLASS_ID              ||= 7
  REPETITION_ID         ||= 8
  CONDITIONAL_ID        ||= 9
  ATTRIBUTE_ID          ||= 10
  BLOCK_ID              ||= 11
  AGGREGATION_ID        ||= 12
  EXTERN_REQUIREMENT_ID ||= 13

  METHOD_LABEL          ||= 'method'
  CONSTRUCTOR_LABEL     ||= 'constructor'
  FUNCTION_LABEL        ||= 'function'
  COMMENT_LABEL         ||= 'comment'
  VARIABLE_LABEL        ||= 'variable'
  MODULE_LABEL          ||= 'module'
  CLASS_LABEL           ||= 'class'
  REPETITION_LABEL      ||= 'repetition'
  CONDITIONAL_LABEL     ||= 'conditional'

end
