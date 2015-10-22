require_relative '../abstract_container/structured_and_oo/attribute.rb'
require_relative '../container_data/structured_and_oo/attribute_data.rb'
require_relative '../../util/html_logger'
require_relative '../../core/setting'

module Languages
  # @module Cplusplus Handling Cplusplus attributes
  module Cplusplus

    # Handle Cplusplus attribute
    class AttributeCplusplus < Languages::Attribute

      public

        def initialize
          @log = @settings = Kuniri::Setting.create.log
          @attributeList = []
        end

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

    private

      @log
      @attributeList

    #Class
    end

  # Cplusplus
  end
#Language
end
