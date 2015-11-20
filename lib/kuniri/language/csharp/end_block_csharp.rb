require_relative '../abstract_container/structured_and_oo/end_block'

module Languages

  module Csharp

    class EndBlockCsharp < Languages::EndBlock

      public

        def has_end_of_block?(pLine)
          # puts detect_end(pLine).to_s
          return detect_end(pLine)
        end

      protected

        def detect_end(pLine)
          return false if pLine =~ /^\s*?\/\/|^\s*?\/\*/
          #TODO: EXTREMELY SIMPLE HANDLING, IT HAVE TO BE IMPROVED!
          if pLine =~ /\/\/\s*\}/
            return false
          elsif pLine =~ /^\s*\}|\s+\}\s*;?|(.*)\}/
            return true
          else
            return false
          end
        end

    # Class
    end

  # Csharp
  end

# Module
end
