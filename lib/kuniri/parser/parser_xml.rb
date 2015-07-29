require 'nokogiri'
require_relative '../language/container_data/structured_and_oo/class_data'

module Parser

  class XML

    def initialize(path = "kuniri.xml")
      @log = @settings = Kuniri::Setting.create.log
      set_path(path)
    end

    def set_path(path)
      @parser_path = path
    end

    # Create the xml output file.
    #   only saves a single ClassData for now
    # @param class_data [ClassData] Receives the ClassData to save
    def create_class_data(class_data)
      @log.write_log("---- PARSER XML ----")
      builder = Nokogiri::XML::Builder.new do |xml|
        generate_class(xml, class_data)
      end

      @builder = builder

      File.open(@parser_path, 'w') do |file|
        file.write(builder.to_xml)
      end
    end

    # Create the xml output file.
    #   only saves a ClassData for now
    # @param parser - Receives the parser
    def create_all_data(parser)
      @log.write_log("---- PARSER XML ----")

      builder = Nokogiri::XML::Builder.new do |xml|
        xml.kuniri {
          for elements in parser.fileLanguage do
            if(elements.fileElements[0].classes.length() > 0)
              generate_class(xml, elements.fileElements[0].classes[0])
            end
          end
        }
      end

      @builder = builder

      File.open(@parser_path, 'w') do |file|
        file.write(builder.to_xml)
      end
    end

    # returns the builder if create method already executed
    def get_builder
      @builder
    end

    # Parse a ClassData to xml
    # @param xml [Nokogiri::XML::Builder] xml builder to edit
    # @param class_data [ClassData] the ClassData to save
    def generate_class(xml, class_data)
      @log.write_log(class_data.name)
      xml.class_data(:name => class_data.name) {
        class_data.methods.each do |o|
          generate_method(xml, o)
        end
        class_data.constructors.each do |c|
          generate_constructor(xml, c)
        end
        class_data.inheritances.each do |i|
          generate_inheritance(xml, i)
        end
      }
    end

    # Parse a InheritanceData to xml
    # @param xml builder to edit
    # @param inheritance_data the InheritanceData to save
    def generate_inheritance(xml, inheritance_data)
      xml.inheritance(:name => inheritance_data[0].strip()) {}
    end

    # Parse a ConstructorData to xml
    # @param xml xml builder to edit
    # @param constructor_data the ConstructorData to save
    def generate_constructor(xml, constructor_data)
      xml.method_(:name => constructor_data.name) {
        constructor_data.parameters.each do |p|
          generate_parameter(xml, p)
        end
      }
    end

    # Parse a MethodData to xml
    # @param xml builder to edit
    # @param method_data the MethodData to save
    def generate_method(xml, method_data)
      xml.method_(:name => method_data.name, :visibility => method_data.visibility) {
        method_data.parameters.each do |p|
          generate_parameter(xml, p)
        end
      }
    end

    # Parse a MethodData to xml
    # @param xml builder to edit
    # @param parameter the Attribute to save
    def generate_parameter(xml, parameter)
      if parameter.kind_of?(String)
        xml.parameter(:name => parameter) {}
      else
        # Is a hash parameter=>defaultValue
        for p in parameter do
          xml.parameter(:name => p[0]+'='+p[1]) {}
        end
      end
    end

    private

    @log

  end
end
