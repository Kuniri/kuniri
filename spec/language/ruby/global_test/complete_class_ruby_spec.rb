require_relative '../../../../lib/kuniri/core/kuniri'

RSpec.describe Kuniri::Kuniri do

  before :each do
    @path = "./spec/language/ruby/global_test/.kuniri"
    @kuniri = Kuniri::Kuniri.new(@path)
    @kuniri.run_analysis

    parser = Parser::XML.new
    parser.set_path("./spec/language/ruby/global_test/output_test.xml")
    parser.create_all_data @kuniri.get_parser()
    @output = File.open("./spec/language/ruby/global_test/output_test.xml", "r")
  end

  it "Should contain the class name" do
    @class_name = nil
    @output.each do |line|
      @class_name = line =~ /\s+<class_data\sname="Abc">/
      break unless @class_name.nil?
    end
    expect(@class_name).not_to be_nil
    @class_end = nil
    @output.each do |line|
      @class_end = line =~ /\s+<\/class_data>$/
      break unless @class_end.nil?
    end
    expect(@class_end).not_to be_nil
  end

  it "Should contain constructor" do
    @constructor = nil
    @output.each do |line|
      @class_name = line =~ /\s+<method\sname="initialize"\/?>/
      break unless @class_name.nil?
    end
  end

  it "Should contain the method name and visibility" do
    @method_name = nil
    @output.each do |line|
      @method_name = line =~ 
      /\s+<method\sname="method1"\svisibility="global"\/?>/
      break unless @method_name.nil?
    end
    expect(@method_name).not_to be_nil

    @method_name = nil
    @output.each do |line|
      @method_name = line =~ 
      /\s+<method\sname="method2"\svisibility="global"\/?>/
      break unless @method_name.nil?
    end
    expect(@method_name).not_to be_nil

    @method_name = nil
    @output.each do |line|
      @method_name = line =~ 
      /\s+<method\sname="method3"\svisibility="global"\/?>/
      break unless @method_name.nil?
    end
    expect(@method_name).not_to be_nil
  end

  it "Should find all methods" do
    @methods = []
    @output.each do |line|
      line_of_method = line =~ 
      /\s+<method\sname="method\d"\svisibility="global"\/?>/
      @methods << line_of_method unless line_of_method.nil?
    end
    expect(@methods.size).to eq(3)
  end

  it "Should contain the parameter name" do
    @parameter_name = nil
    @output.each do |line|
      @parameter_name = line =~ /\s+<parameter\sname="x"\/>/
      break unless @parameter_name.nil?
    end
    expect(@parameter_name).not_to be_nil

    @parameter_name = nil
    @output.each do |line|
      @parameter_name = line =~ /\s+<parameter\sname="a"\/>/
      break unless @parameter_name.nil?
    end
    expect(@parameter_name).not_to be_nil

    @parameter_name = nil
    @output.each do |line|
      @parameter_name = line =~ /\s+<parameter\sname="b"\/>/
      break unless @parameter_name.nil?
    end
    expect(@parameter_name).not_to be_nil

    @parameter_name = nil
    @output.each do |line|
      @parameter_name = line =~ /\s+<parameter\sname="c"\/>/
      break unless @parameter_name.nil?
    end
    expect(@parameter_name).not_to be_nil
  end


  it "Should find all parameters" do
    @parameters = []
    @output.each do |line|
      line_of_parameter = line =~ /\s+<parameter\sname="\w+"\/>/
      @parameters << line_of_parameter unless line_of_parameter.nil?
    end
    expect(@parameters.size).to eq(4)
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
