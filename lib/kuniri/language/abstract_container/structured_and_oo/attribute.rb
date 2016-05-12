module Languages

  # @abstract Abstract class for handling attribute.
  class Attribute

    public

      def initialize
        @whoAmI = 'attribute'
      end

      # Verify if a line has an attribute. If it has attribute, firstly, the
      # function capture all lines and removes specific language declaration
      # (for instance, in ruby it is:  '@' or ':' and whitespace), finally
      # it splits the string by an special character and return an object of
      # AttributeData.
      # @param pLine An line to be analysed for find attribute.
      # @return Return on filled object of AttributeData if it find an
      #         attribute, otherwise it returns nil.
      def get_attribute(pLine)
        @variableBehaviour.common_declaration(pLine, @detectRegex)
      end

      # Setup basic configurations for make attribute work correctly. It is
      # mandatory to call it with the correct parameters in the child class.
      # @param pVariableBehaviour Reference to a variable behaviour.
      # @param pRegex Regex to detect if is an attribute.
      def setup_attribute(pVariableBehaviour, pRegex)
        @detectRegex = pRegex if is_regex?(pRegex)
        @variableBehaviour = pVariableBehaviour
      end

    protected

      @whoAmI
      @detectRegex
      @variableBehaviour

      def is_regex?(pRegex)
        return pRegex.instance_of?Regexp
      end

  # Class
  end

# Language
end
