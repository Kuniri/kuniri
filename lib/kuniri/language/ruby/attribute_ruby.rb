require_relative '../abstract_container/structured_and_oo/attribute'
require_relative '../container_data/structured_and_oo/attribute_data'
require_relative '../../core/setting'

module Languages

  module Ruby

    # Ruby Handling Ruby attributes
    class AttributeRuby < Languages::Attribute

      public

        def initialize
          @attributeList = []
        end

        # Get ruby attribute.
        # @param pLine Verify if line has a ruby attribute.
        # @return Return AttributeData or nil.
        def get_attribute(pLine)
          result = detect_attribute(pLine)
          return nil unless result

          listOfAttributes = []

          # Has comma? Split string by comma
          result = remove_unnecessary_information(result)

          # Separated by comma, equal or the common case
          if result.scan(/,/).count >= 1
            listOfAttributes = handle_multiple_declaration_with_comma(result)
          elsif result.scan(/=/).count > 1
            listOfAttributes = handle_multiple_declaration_with_equal(result)
          else
            listOfAttributes = handle_line_declaration(result)
          end

          return listOfAttributes
        end

    protected

      # Override
      def detect_attribute(pLine)
        regexExp = /^\s*(?:@|attr_(?:accessor|read|write))(.*)$/
        return nil unless pLine =~ regexExp
        return pLine.scan(regexExp)[0].join("")
      end

      # Override
      def remove_unnecessary_information(pString)
        return pString.gsub!(/\(.*\)/,"") if pString =~ /\(.*\)/
        return pString
      end

      # Override
      def prepare_final_string(pString)
        if pString =~ /\s+|:|@|=/
          return pString.gsub!(/\s+|:|@|=/,"")
        end
        return pString
      end

      # Override
      def handle_multiple_declaration_with_comma(pString)
        return handle_multiple_declaration(pString, ",") do |variable|
          variable = variable.scan(/.*=/).join("") if variable =~ /.*=/
          variable
        end
      end

      # Override
      def handle_multiple_declaration_with_equal(pString)
        return handle_multiple_declaration(pString, "="){ |variable| variable }
      end

    private

      @attributeList

      def handle_line_declaration(pString)
        return handle_line(pString){ |pString| pString }
      end

      def handle_line(pString)
        if pString =~ /=/
          pString = pString.scan(/.*=/).join("")
          return nil if pString =~ /\./
        end

        pString = yield(pString)

        return nil if pString =~ /\./

        pString = prepare_final_string(pString)
        attribute = Languages::AttributeData.new(pString)

        return [attribute]
      end

      def handle_multiple_declaration(pString, pSplitChar)
        listOfAttributes = []
        pString = pString.split(pSplitChar)
        pString.each do |variable|
          attribute = handle_line(variable) { |pString| yield(pString) }
          listOfAttributes.concat(attribute) if attribute
        end

        return listOfAttributes
      end

    #Class
    end

  # Ruby
  end
#Language
end
