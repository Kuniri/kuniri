require_relative '../abstract_container/extern_requirement'
require_relative '../container_data/extern_requirement_data'
require_relative '../../util/html_logger'

module Languages

  module Ruby

    class ExternRequirementRuby < Languages::ExternRequirement

      public

        def get_requirement(pLine)
          raise NotImplementedError
        end

      protected

        def detect_extern_requirement(pLine)
          raise NotImplementedError
        end

        def remove_unnecessary_information(pLine)
          raise NotImplementedError
        end

    # Class
    end

  # Module
  end

# Module
end 
