#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

module Languages

  # Token types used for standardize assignments.
  IF_LABEL ||= 'IF'.freeze
  ELSE_LABEL ||= 'ELSE'.freeze
  ELSIF_LABEL ||= 'ELSIF'.freeze
  UNLESS_LABEL ||= 'UNLESS'.freeze
  TERNARY_LABEL ||= 'TERNARY'.freeze
  CASE_LABEL ||= 'CASE'.freeze
  WHEN_LABEL ||= 'WHEN'.freeze
  WHILE_LABEL ||= 'WHILE'.freeze
  FOR_LABEL ||= 'FOR'.freeze
  DO_WHILE_LABEL ||= 'DOWHILE'.freeze
  UNTIL_LABEL ||= 'UNTIL'.freeze
  LAMBDA_BLOCK_LABEL ||= 'LAMDA_BLOCK'.freeze
  # Handle nested conditional and loops
  UP_LEVEL ||= -1
  DOWN_LEVEL ||= 1
  KEEP_LEVEL ||= 0

  UNKNOWN ||= 'nothing'.freeze

end
