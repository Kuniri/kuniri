require_relative '../abstract_container/structured_and_oo/variable_global'
require_relative '../container_data/structured_and_oo/variable_global_data'

module Languages

  module Ruby

    # @class ExternRequirement Handling extern requirements.
    class VariableGlobalRuby < Languages::VariableGlobal

      public

        def get_variable(pLine)
          detectExpression = detect_variable(pLine)
          return nil unless detectExpression

          detectExpression = remove_unnecessary_information(detectExpression)
          variable = VariableGlobalData.new(name)
          return variable
        end

      protected

        def detect_variable(pLine)
          # TODO: CREATE IT! SEE THE EXAMPLE BELOW

          #regexExpression = /(?:require_relative|require)\s*['|"](.*)['|"]/
          #return nil unless pLine =~ regexExpression
          #return pLine.scan(regexExpression).join("")
        end

        def remove_unnecessary_information(pLine)
          # TODO: CREATE IT! SEE THE EXAMPLE BELOW

          #regexClean = /\s*|"|'/
          #return pLine.gsub!(regexClean, "") if pLine =~ regexClean
          #return pLine
        end

    # Class
    end

  # Module
  end

# Module
end
