require_relative '../../../spec_helper'

RSpec.describe Kuniri::Kuniri do

  before :each do
    @path = "./spec/language/ruby/global_test/.kuniri.yml"
    @kuniri = Kuniri::Kuniri.new
    @kuniri.read_configuration_file(@path)
    @kuniri.run_analysis
    parser = Parser::XMLOutputFormat.new(@kuniri.configurationInfo[:output])
    parser.create_all_data(@kuniri.get_parser())
    @output =
           File.open("./spec/language/ruby/global_test/simpleFullCode.xml", "r")
  end

  it "Should contain the class name" do
    @class_name = nil
    @output.each do |line|
      @class_name = line =~ /\s+<classData\sname="Abc"\svisibility="public">/
      break unless @class_name.nil?
    end
    expect(@class_name).not_to be_nil
    @class_end = nil
    @output.each do |line|
      @class_end = line =~ /\s+<\/classData>$/
      break unless @class_end.nil?
    end
    expect(@class_end).not_to be_nil
  end

  it "Should contain constructor" do
    @constructor = nil
    @output.each do |line|
      @class_name =
            line =~ /\s+<methodData\sname="initialize"\svisibility="public"\/?>/
      break unless @class_name.nil?
    end
  end

  context "Validade method" do
    it "Find method1" do
      @method_name = nil
      @output.each do |line|
        @method_name = line =~
        /\s+<methodData\sname="method1"\svisibility="public"\/?>/
        break unless @method_name.nil?
      end
      expect(@method_name).not_to be_nil
    end

    it "Find method2" do
      @method_name = nil
      @output.each do |line|
        @method_name = line =~
        /\s+<methodData\sname="method2"\svisibility="public"\/?>/
        break unless @method_name.nil?
      end
      expect(@method_name).not_to be_nil
    end

    it "Find method3" do
      @method_name = nil
      @output.each do |line|
        @method_name = line =~
        /\s+<methodData\sname="method3"\svisibility="public"\/?>/
        break unless @method_name.nil?
      end
      expect(@method_name).not_to be_nil
    end
  end

  it "Should find all methods" do
    @methods = []
    @output.each do |line|
      line_of_method = line =~
      /\s+<methodData\sname="method\d"\svisibility="public"\/?>/
      @methods << line_of_method unless line_of_method.nil?
    end
    expect(@methods.size).to eq(3)
  end

  it "Should contain the parameter name" do
    @parameter_name = nil
    @output.each do |line|
      @parameter_name = line =~ /\s+<parameterData\sname="x"\/>/
      break unless @parameter_name.nil?
    end
    expect(@parameter_name).not_to be_nil

    @parameter_name = nil
    @output.each do |line|
      @parameter_name = line =~ /\s+<parameterData\sname="a"\/>/
      break unless @parameter_name.nil?
    end
    expect(@parameter_name).not_to be_nil

    @parameter_name = nil
    @output.each do |line|
      @parameter_name = line =~ /\s+<parameterData\sname="b"\/>/
      break unless @parameter_name.nil?
    end
    expect(@parameter_name).not_to be_nil

    @parameter_name = nil
    @output.each do |line|
      @parameter_name = line =~ /\s+<parameterData\sname="c"\/>/
      break unless @parameter_name.nil?
    end
    expect(@parameter_name).not_to be_nil
  end


  it "Should find all parameters" do
    @parameters = []
    @output.each do |line|
      line_of_parameter = line =~ /\s+<parameterData\sname="\w+"\/>/
      @parameters << line_of_parameter unless line_of_parameter.nil?
    end
    expect(@parameters.size).to eq(4)
  end

  it "Should contain the inheritance name" do
    @inheritance_name = nil
    @output.each do |line|
      @inheritance_name =
           line =~ /\s+<inheritanceData\s+name="Array"\s+isInProject="false"\/>/
      break unless @inheritance_name.nil?
    end
    expect(@inheritance_name).not_to be_nil
  end

  it "Should find all inheritances" do
    @inheritance = []
    @output.each do |line|
      line_of_inheritance =
               line =~ /\s+<inheritanceData\s+name="\w+"\s+isInProject="\w+"\/>/
      @inheritance << line_of_inheritance unless line_of_inheritance.nil?
    end
    expect(@inheritance.size).to eq(1)
  end

  it "Should contain the aggregation name" do
    @aggregation_name = nil
    @output.each do |line|
      @aggregation_name =
           line =~ /\s+<aggregationData\s+name="Array"\s+isInProject="false"\/>/
      break unless @aggregation_name.nil?
    end
    expect(@aggregation_name).not_to be_nil
  end

  it "Should find all aggregations" do
    @aggregation = []
    @output.each do |line|
      line_of_aggregation =
               line =~ /\s+<aggregationData\s+name="\w+"\s+isInProject="\w+"\/>/
      @aggregation << line_of_aggregation unless line_of_aggregation.nil?
    end
    expect(@aggregation.size).to eq(1)
  end

  it "Should verify the opening-closing structure" do
    @stack = []
    @output.each do |line|
      next if line =~ /<\?xml.*/
      next if line =~ /.*\/>/

      if line =~ /\s*<\/(\w*)>/
        expect(@stack.last).to eq($1)
        @stack.pop
      elsif line =~ /\s*<(\w*)(.*)>/
        @stack.push $1
      end
    end

    expect(@stack.size).to eq(0)

  end

  after :each do
    @kuniri = nil
    @output = nil
  end

end
