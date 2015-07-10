require_relative '../abstract_container/structured_and_oo/repetition.rb'
require_relative '../container_data/structured_and_oo/repetition_data.rb'

module Languages

  module Ruby

    class RepetitionRuby < Languages::Repetition

      public

        def get_repetition(pLine)
          result = detect_repetition(pLine)
          return nil unless result

          repetitionCaptured = Languages::RepetitionData.new
          repetitionCaptured.type = repetition_type(pLine)

          repetitionCaptured.expression = get_expression(result)

          return repetitionCaptured
        end

      protected

        def detect_repetition(pLine)
          regexExp = /^\s*while\s+(.*)do/
          return pLine.scan(regexExp)[0].join("") if regexExp =~ pLine

          regexExp = /^\s*for\s+(.*)/
          return pLine.scan(regexExp)[0].join("") if regexExp =~ pLine

          return nil
        end

        def repetition_type(pString)
          regexExp = /^\s+while|^while/
          return "WHILE" if regexExp =~ pString

          regexExp = /^\s+for|^for/
          return "FOR" if regexExp =~ pString

          return nil
        end

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
