#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

module Languages

  # Token types used for standardize assignments.
  IF_LABEL ||= 'IF'
  ELSE_LABEL ||= 'ELSE'
  ELSIF_LABEL ||= 'ELSIF'
  UNLESS_LABEL ||= 'UNLESS'
  CASE_LABEL ||= 'CASE'
  WHEN_LABEL ||= 'WHEN'
  WHILE_LABEL ||= 'WHILE'
  FOR_LABEL ||= 'FOR'
  DO_WHILE_LABEL ||= 'DOWHILE'
  UNTIL_LABEL ||= 'UNTIL'
  LAMBDA_LABEL ||= 'LAMBDA'
  BLOCK_LABEL ||= 'BLOCK'
  # Handle nested conditional and loops
  UP_LEVEL ||= -1
  DOWN_LEVEL ||= 1
  KEEP_LEVEL ||= 0

  UNKNOWN ||= 'nothing'

end
