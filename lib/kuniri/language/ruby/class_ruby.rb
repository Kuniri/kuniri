require_relative '../abstract_container/structured_and_oo/class'
require_relative '../container_data/structured_and_oo/class_data'
require_relative '../../core/setting'

module Languages

  module Ruby

    # Class responsible for handling ruby classes.
    class ClassRuby < Languages::Class

      public

        # Get ruby class.
        # @see Languages::Class
        def get_class(pLine)
          result = detect_class(pLine)
          return nil unless result

          classCaptured = Languages::ClassData.new

          inheritance = get_inheritance(result)
          classCaptured.add_inheritance(inheritance) if inheritance

          result = prepare_final_string(result)
          classCaptured.name = result

          return classCaptured
        end

      protected

        # Override
        def detect_class(pLine)
          regex = /^\s*class\s+(.*)/
          pLine =~ regex ? pLine[regex, 1] : nil
        end

        # Override
        def get_inheritance(pString)
          if pString =~ /</
            partial = pString.split('<').last.strip
            partial = partial.split('::').last.strip
            return partial
          end

          return nil
        end

        # Override
        def remove_unnecessary_information(pString)
          regex = /\s|</
          pString =~ regex ? pString.gsub(regex, '') : pString
        end

        def prepare_final_string(pString)
          if pString =~ /\s|</
            partial = pString.gsub(/<.*/,'')
            return remove_unnecessary_information(partial)
          end
          return pString
        end
    # class
    end
  # Ruby
  end
# Languages
end
