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
          regexExp = /^\s*while\s+(.*)do/
          return pLine[regexExp, 0] if regexExp =~ pLine

          regexExp = /^\s*for\s+(\w+)\s+in\s+(.+)/
          return pLine[regexExp, 0] if regexExp =~ pLine

          regexExp = /^\s*until\s+(.*)do/
          return pLine[regexExp, 0] if regexExp =~ pLine

          regexExp = /^\s*end\s+while\s+(.*)/
          return pLine[regexExp, 0] if regexExp =~ pLine

          regexExp = /(lambda)\s+do(.*)\s*/
          return pLine[regexExp, 0] if regexExp =~ pLine

          # TODO: BUG in this case -> puts "test.each do |x|"
          regexExp = /\.(\s*\w+)\s+do(.*)\s*/
          return pLine[regexExp, 0] if regexExp =~ pLine

          return nil
        end

        # Override
        def repetition_type(pString)
          regexExp = /^\s+while|^while/
          return "WHILE" if regexExp =~ pString

          regexExp = /^\s+for|^for/
          return "FOR" if regexExp =~ pString

          regexExp = /^\s+until|^until/
          return "UNTIL" if regexExp =~ pString

          regexExp = /^\s*end\s+while\s+/
          return "DOWHILE" if regexExp =~ pString

          regexExp = /^lambda\s+/
          return "LAMBDA" if regexExp =~ pString

          regexExp = /\.\w+/
          return pString[/\w+/, 0].upcase if regexExp =~ pString

          return nil
        end

        # Override
        def get_expression(pType, pString)
          if pType == "FOR"
            pString.slice!("for")
          elsif pType == "WHILE"
            pString.slice!("while")
            pString.slice!("do")
          elsif pType == "UNTIL"
            pString.slice!("until")
            pString.slice!("do")
          elsif pType == "DOWHILE"
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
