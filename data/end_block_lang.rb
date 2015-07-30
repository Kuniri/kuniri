require_relative '../abstract_container/structured_and_oo/end_block'

module Languages

  module {LANG}

    class EndBlockRuby < Languages::EndBlock

      public

        def has_end_of_block?(pLine)
          return detect_end(pLine)
        end

      protected

        def detect_end(pLine)
          #TODO: EXTREMELY SIMPLE HANDLING, IT HAVE TO BE IMPROVED!
          return true if pLine =~ /^\s+end|^end/
          return false
        end

    # Class
    end

  # {LANG}
  end

# Module
end
