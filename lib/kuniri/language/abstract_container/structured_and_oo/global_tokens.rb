module Languages

  # Token types used for standardize assignments.
  IF_LABEL ||= "IF"
  ELSE_LABEL ||= "ELSE"
  ELSIF_LABEL ||= "ELSIF"
  UNLESS_LABEL ||= "UNLESS"
  CASE_LABEL ||= "CASE"
  WHILE_LABEL ||= "WHILE"
  FOR_LABEL ||= "FOR"
  DO_WHILE_LABEL ||= "DOWHILE"
  UNTIL_LABEL ||= "UNTIL"
  LAMBDA_LABEL ||= "LAMBDA"
  # Handle nested conditional and loops
  UP_LEVEL ||= -1
  DOWN_LEVEL ||= 1
  KEEP_LEVEL ||= 0

end
