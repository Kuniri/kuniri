require_relative '../abstract_container/attribute.rb'
require_relative '../container_data/attribute_data.rb'

module Languages
  # @module Ruby Handling Ruby attributes
  module Ruby

    # Handle ruby attribute
    class AttributeRuby < Languages::Attribute

      public

        def get_attribute(line)
          # Detect attribute
          result = detect_attribute(line)
          return nil unless result

          listOfAttributes = []

          # Has comma? Split string by comma
          result = remove_unecessary_information(result)

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
        return (pLine.scan(regexExp)[0]).join("")
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
        listOfAttributes = []
        pString = pString.split(",")
        pString.each do |variable|
          return nil if variable.scan(/=/).count > 1

          variable = variable.scan(/.*=/).join("") if variable =~ /.*=/

          return nil if variable =~ /\./

          variable = prepare_final_string(variable)
          attribute = Languages::AttributeData.new(variable)
          listOfAttributes.push(attribute)
        end

        return listOfAttributes
      end

      # Override
      def handle_multiple_declaration_with_equal(pString)
        listOfAttributes = []
        pString = pString.split("=")
        pString.each do |variable|
          return nil if variable =~ /\./

          variable = prepare_final_string(variable)
          attribute = Languages::AttributeData.new(variable)
          listOfAttributes.push(attribute)
        end

        return listOfAttributes
      end

      # Override
      def handle_line_declaration(pString)
        listOfAttributes = []
        if pString =~ /=/
          pString = pString.scan(/.*=/).join("")
          return nil if pString =~ /\./
        end

        return nil if pString =~ /\./

        pString = prepare_final_string(pString)
        attribute = Languages::AttributeData.new(pString)
        listOfAttributes.push(attribute)

        return listOfAttributes
      end

    #Class
    end
  # Ruby
  end
#Language
end
