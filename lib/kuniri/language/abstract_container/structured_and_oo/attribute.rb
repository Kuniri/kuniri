module Languages

  # @abstract Abstract class for handling attribute.
  class Attribute

    public

      def initialize(pVariableBehaviour, pRegex)
        @whoAmI = 'attribute'
        @detectRegex = pRegex
        @variableBehaviour = pVariableBehaviour
      end

      # Verify if a line has an attribute. If it has attribute, firstly, the
      # function capture all lines and removes specific language declaration
      # (for instance, in ruby it is:  "@" or ":" and whitespace), finally
      # it splits the string by an special character and return an object of
      # AttributeData.
      # @param pLine An line to be analysed for find attribute.
      # @return Return on filled object of AttributeData if it find an
      #         attribute, otherwise it returns nil.
      def get_attribute(pLine)
        @variableBehaviour.common_declaration(pLine, @detectRegex)
      end

    protected

      @whoAmI
      @detectRegex
      @variableBehaviour

  # Class
  end

# Language
end
