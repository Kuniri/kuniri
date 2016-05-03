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
        regexExp = /^\s*(?:@|attr_(?:accessor|reader|writer))(.*)$/
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
        return handle_multiple_declaration(pString, ',') do |variable|
          if variable =~ /.*=/
            variable = variable.scan(/.*=/).join('')
          end
          variable
        end
      end

      # Override
      def handle_multiple_declaration_with_equal(pString)
        tmp  = pString.split('=')
        value = handle_value(tmp.last) if pString =~ /=/
        return handle_multiple_declaration(pString, '=', value){ |variable| variable }
      end

    private

      @attributeList

      def handle_line_declaration(pString)
        value = handle_value(pString) if pString =~ /=/
        return handle_line(pString, value){ |pString| pString }
      end

      def handle_line(pString, value = 'nothing')
        if pString =~ /=/
          value = handle_value(pString)
          pString = pString.scan(/.*=/).join("")
          return nil if pString =~ /\./
        end

        pString = yield(pString)

        return nil if pString =~ /\./

        pString = prepare_final_string(pString)
        attribute = Languages::AttributeData.new(pString)
        attribute.value = value

        return [attribute]
      end

      def handle_multiple_declaration(pString, pSplitChar, value = 'nothing')
        listOfAttributes = []
        pString = pString.split(pSplitChar)
        pString.each do |variable|
          if pSplitChar == '='
            attribute = handle_line(variable, value) { |pString| yield(pString) }
          else
            attribute = handle_line(variable) { |pString| yield(pString) }
          end
          listOfAttributes.concat(attribute) if attribute
        end

        return listOfAttributes
      end

      def handle_value(pString)
        value = pString
        value = pString.scan(/=(.*)/).join("") if pString =~ /=/
        value = value.lstrip
        value = value.rstrip
        value = value.gsub(/'|\"/,"")
        return value
      end


    #Class
    end

  # Ruby
  end
#Language
end
