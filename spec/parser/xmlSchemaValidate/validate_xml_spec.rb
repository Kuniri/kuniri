require_relative '../../spec_helper'
require 'xml'

RSpec.describe 'Xml Schema Validate' do

  before :all do
    @targetFolder = './spec/parser/xmlSchemaValidate/'
  end

  RSpec.shared_examples 'Multiple validation' do |config, xmlOutput, xsdFile, description|

    it "Validate XSD: #{description}" do
      kuniri = Kuniri::Kuniri.new
      kuniri.read_configuration_file(@targetFolder + config)
      kuniri.run_analysis
      parser = Parser::XMLOutputFormat.new(0, kuniri.configurationInfo[:output])
      parser.create_all_data(kuniri.get_parser())
      xml = XML::Document.file(@targetFolder + xmlOutput)
      schema = XML::Schema.document(XML::Document.file(@targetFolder + xsdFile))

      expect(xml.validate_schema(schema)).to be true
    end

  end

  context 'When have support to the parser.' do

    config = '.kuniri1.yml'
    xsd = 'fullCodeTwo.xsd'
    xml = 'fullCodeTwo.xml'
    description = 'Check simple class'
    include_examples 'Multiple validation', config, xml, xsd, description

    config = '.kuniri2.yml'
    xsd = 'fullCodeWithComments.xsd'
    xml = 'fullCodeWithComments.xml'
    description = 'Check class with comments'
    include_examples 'Multiple validation', config, xml, xsd, description

    config = '.kuniri3.yml'
    xsd = 'simpleFunction.xsd'
    xml = 'simpleFunction.xml'
    description = 'Check simple function'
    include_examples 'Multiple validation', config, xml, xsd, description

  end

  after :all do
    @targetFolder = nil
  end

end
