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
          result = result.join("")
          result = remove_unecessary_information(result)

          # Separed by comma
          if result.scan(/,/).count >= 1
            listOfAttributes = handle_multiple_declaration_with_comma(result)
          # Has sequence of "="?
          elsif result.scan(/=/).count > 1
            listOfAttributes = handle_multiple_declaration_with_equal(result)
          # Normal case
          else
            listOfAttributes = handle_line_declaration(result)
          end

          return listOfAttributes
        end

    protected

      def detect_attribute(pLine)
        regexExp = /^\s*(?:@|attr_(?:accessor|read|write))(.*)$/
        return nil unless pLine =~ regexExp
        return pLine.scan(regexExp)[0]
      end

      def remove_unecessary_information(pString)
        return pString.gsub!(/\(.*\)/,"") if pString =~ /\(.*\)/
        return pString
      end

      def prepare_final_string(line)
        return line.gsub!(/\s+|:|@|=/,"")
      end

      def handle_multiple_declaration_with_comma(pString)
        listOfAttributes = []
        pString = pString.split(",")
        pString.each do |variable|
          # TODO: BUG!!! FIXME FAST! 
          return nil if variable.scan(/=/).count > 1

          variable = variable.scan(/.*=/)
          return nil if variable =~ /\./

          variable = prepare_final_string(variable.join(""))
          attribute = Languages::AttributeData.new(variable)
          listOfAttributes.push(attribute)
        end

        return listOfAttributes
      end

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

      def handle_line_declaration(pString)
        listOfAttributes = []
        if pString =~ /=/
          pString = pString.scan(/.*=/)
          pString = pString.join("")
          return nil if pString =~ /\./
        end

        return nil if pString =~ /\./

        pString = prepare_final_string(pString) if pString =~ /\s+|:|@|=/
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
