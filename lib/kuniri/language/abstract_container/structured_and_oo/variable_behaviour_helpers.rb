module Languages

  module VariableBehaviourHelpers

    # Setup basic configurations for make attribute work correctly. It is
    # mandatory to call it with the correct parameters in the child class.
    # @param pVariableBehaviour Reference to a variable behaviour.
    # @param pRegex Regex to detect if is an attribute.
    def setup_attribute(pVariableBehaviour, pRegex)
      @detectRegex = pRegex if is_regex?(pRegex)
      @variableBehaviour = pVariableBehaviour
    end

    def is_regex?(pRegex)
      return pRegex.instance_of?Regexp
    end

  end

end
