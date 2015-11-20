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

          repetitionCaptured = Languages::RepetitionData.new
          repetitionCaptured.type = repetition_type(result)

          repetitionCaptured.expression = get_expression(result)

          return repetitionCaptured
        end

      protected

        # Override
        def detect_repetition(pLine)
          regexExp = /^\s*while\s+(.*)do/
          return pLine.scan(regexExp)[0].join("") if regexExp =~ pLine

          regexExp = /^\s*for\s+(.*)/
          return pLine.scan(regexExp)[0].join("") if regexExp =~ pLine

          regexExp = /^\s*until\s+(.*)do/
          return pLine.scan(regexExp)[0].join("") if regexExp =~ pLine

          regexExp = /(lambda)\s+do(.*)\s*/
          return pLine.scan(regexExp)[0].join("") if regexExp =~ pLine

          regexExp = /(\.\s*each)\s+do(.*)\s*/
          return pLine.scan(regexExp)[0].join("") if regexExp =~ pLine

          return nil
        end

        # Override
        def repetition_type(pString)
          regexExp = /^\s+while|^while/
          return "WHILE" if regexExp =~ pString

          regexExp = /^\s+for|^for/
          return "FOR" if regexExp =~ pString

          regexExp = /^each\s+/
          return "EACH" if regexExp =~ pString

          regexExp = /^lambda\s+/
          return "LAMBDA" if regexExp =~ pString

          return nil
        end

        # Override
        def get_expression(pString)
          leftStrip = pString.lstrip
          rightStrip = leftStrip.rstrip
          return rightStrip
        end

    # class
    end

  # Module
  end

# Module
end
