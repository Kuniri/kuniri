require_relative '../abstract_container/structured_and_oo/attribute'
require_relative '../container_data/structured_and_oo/attribute_data'
require_relative '../../util/html_logger'
require_relative '../../core/setting'

module Languages

  module Ruby

    # Ruby Handling Ruby attributes
    class AttributeRuby < Languages::Attribute

      public

        def initialize
          @log = @settings = Kuniri::Setting.create.log
          @attributeList = []
        end

        # Get ruby attribute.
        # @param pLine Verify if line has a ruby attribute.
        # @return Return AttributeData or nil.
        def get_attribute(pLine)
          result = detect_attribute(pLine)
          return nil unless result

          @log.write_log("Info: Prepare to get attribute.")

          listOfAttributes = []

          # Has comma? Split string by comma
          result = remove_unnecessary_information(result)

          # Separated by comma, equal or the common case
          if result.scan(/,/).count >= 1
            listOfAttributes = handle_multiple_declaration_with_comma(result)
            @log.write_log("Debug: Declared with comma: #{listOfAttributes}")
          elsif result.scan(/=/).count > 1
            listOfAttributes = handle_multiple_declaration_with_equal(result)
            @log.write_log("Debug: separed by comma: #{listOfAttributes}")
          else
            listOfAttributes = handle_line_declaration(result)
            @log.write_log("Debug: One line declaration #{listOfAttributes}")
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

      # Override
      def handle_line_declaration(pString)
        return handle_line(pString){ |pString| pString }
      end

      # Override
      def handle_multiple_declaration(pString, splitChar)
        listOfAttributes = []
        pString = pString.split(splitChar)
        pString.each do |variable|
          attribute = handle_line(variable) { |pString| yield(pString) }
          listOfAttributes.concat(attribute) if attribute
        end

        return listOfAttributes
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

      @log
      @attributeList

    #Class
    end

  # Ruby
  end
#Language
end
