require_relative '../abstract_container/structured_and_oo/global_tokens'
require_relative '../abstract_container/structured_and_oo/repetition'
require_relative '../container_data/structured_and_oo/repetition_data'

module Languages

  module Ruby

    # Class responsible for handling Ruby repetition data structures.
    class RepetitionRuby < Languages::Repetition

      public

        # Get Ruby repetition structure.
        # @see Languages::Repetition
        def get_repetition(pLine)
          result = detect_repetition(pLine)
          return nil unless result
          #result = remove_unnecessary_information(result)
          repetitionCaptured = Languages::RepetitionData.new
          repetitionCaptured.type = repetition_type(result)
          repetitionCaptured.expression = get_expression(
                                                    repetitionCaptured.type,
                                                    result)
          return repetitionCaptured
        end

      protected

        # Override
        def detect_repetition(pLine)
          regexExp = /^\s*while\s+(.*)/
          return pLine[regexExp, 0] if regexExp =~ pLine

          regexExp = /^\s*for\s+(\w+)\s+in\s+(.+)(\bdo\b)?/
          return pLine[regexExp, 0] if regexExp =~ pLine

          regexExp = /^\s*until\s+(.*)(\bdo\b)?/
          return pLine[regexExp, 0] if regexExp =~ pLine

          regexExp = /^\s*end\s+while\s+(.+)/
          return pLine[regexExp, 0] if regexExp =~ pLine

          regexExp = /(lambda)\s+do(.*)\s*/
          return pLine[regexExp, 0] if regexExp =~ pLine

          return nil
        end

        # Override
        def repetition_type(pString)
          regexExp = /^\s+while|^while/
          return Languages::WHILE_LABEL if regexExp =~ pString

          regexExp = /^\s+for|^for/
          return Languages::FOR_LABEL if regexExp =~ pString

          regexExp = /^\s+until|^until/
          return Languages::UNTIL_LABEL if regexExp =~ pString

          regexExp = /^\s*end\s+while\s+/
          return Languages::DO_WHILE_LABEL if regexExp =~ pString

          regexExp = /^lambda\s+/
          return Languages::LAMBDA_LABEL if regexExp =~ pString

          return nil
        end

        # Override
        def get_expression(pType, pString)
          case pType
            when Languages::FOR_LABEL
              pString.slice!("for")
              pString.slice!("do")
            when Languages::WHILE_LABEL
              pString.slice!("while")
              pString.slice!("do")
            when Languages::UNTIL_LABEL
              pString.slice!("until")
              pString.slice!("do")
            when Languages::DO_WHILE_LABEL
              pString.slice!("end")
              pString.slice!("while")
            else
              pString.slice!(".")
          end
          leftStrip = pString.lstrip
          rightStrip = leftStrip.rstrip

          return rightStrip
        end

        # Override
        def remove_unnecessary_information(pString)
          return pString.gsub(/\./,"") if pString =~ /\./
          return pString
        end

    # class
    end

  # Module
  end

# Module
end
