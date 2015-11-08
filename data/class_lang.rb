require_relative '../abstract_container/structured_and_oo/class.rb'
require_relative '../container_data/structured_and_oo/class_data.rb'
require_relative '../../core/setting'

module Languages

  module {LANG}

    class Class{LANG} < Languages::Class

      public

        def initialize
        end

        def get_class(pLine)
          result = detect_class(pLine)
          return nil unless result

          classCaptured = Languages::ClassData.new

          inheritance = get_inheritance(result)
          classCaptured.inheritances = inheritance if inheritance

          result = prepare_final_string(result)
          classCaptured.name = result

          return classCaptured
        end

      protected

        def detect_class(pLine)
          regexExpression = /^\s*class\s+(.*)/
          return nil unless pLine =~ regexExpression
          return pLine.scan(regexExpression)[0].join("")
        end

        def get_inheritance(pString)
          if pString =~ /</
            partial = pString.scan(/<(.*)/)
            return remove_unnecessary_information(partial)
          end
          return nil
        end

      def remove_unnecessary_information(pString)
        return pString.gsub(/\s|</, "") if pString =~ /\s|</
        return pString
      end

      def prepare_final_string(pString)
        if pString =~ /\s|</
          partial = pString.gsub(/<.*/,"")
          return remove_unnecessary_information(partial)
        end
        return pString
      end

    private

    # class
    end

  # {LANG}
  end

# Languages
end
