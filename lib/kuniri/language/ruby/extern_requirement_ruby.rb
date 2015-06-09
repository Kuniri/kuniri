require_relative '../abstract_container/structured_and_oo/extern_requirement'
require_relative '../container_data/structured_and_oo/extern_requirement_data'

module Languages

  module Ruby

    # @class ExternRequirement Handling extern requirements.
    class ExternRequirementRuby < Languages::ExternRequirement

      public

        def get_requirement(pLine)
          detectExpression = detect_extern_requirement(pLine)
          return nil unless detectExpression

          detectExpression = remove_unnecessary_information(detectExpression)
          # @requirement = detectExpression
          name = File.basename(detectExpression, ".*")
          externReference = ExternRequirementData.new(name)
          return externReference
        end

        #def get_requirement
        #  return detectExpression
        #end

      protected

        def detect_extern_requirement(pLine)
          regexExpression = /(?:require_relative|require)\s*['|"](.*)['|"]/
          return nil unless pLine =~ regexExpression
          return pLine.scan(regexExpression).join("")
        end

        def remove_unnecessary_information(pLine)
          regexClean = /\s*|"|'/
          return pLine.gsub!(regexClean, "") if pLine =~ regexClean
          return pLine
        end

    # Class
    end

  # Module
  end

# Module
end 
