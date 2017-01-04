require_relative '../../../../spec_helper'

RSpec.describe Kuniri::Kuniri do

  before :each do
    @path = "./spec/language/ruby/global_test/global_variable/.kuniri.yml"
    @kuniri = Kuniri::Kuniri.new
    @kuniri.read_configuration_file(@path)
    @kuniri.run_analysis
    parser = Parser::XMLOutputFormat.new(@kuniri.configurationInfo[:output])
    parser.create_all_data(@kuniri.get_parser())
    target = "./spec/language/ruby/global_test/global_variable/simpleVariable.xml"
    @output = File.open(target, "r")
  end

  RSpec.shared_examples "global variable" do |regex, description|
    it "Global variable: #{description}" do
      variable = nil
      @output.each do |line|
        variable = line =~ regex
        break unless variable.nil?
      end
      expect(variable).not_to be_nil
    end
  end

  context "Simple cases of global variable" do

    message = "instance global variable"
    regex = /\s+<globalVariableData\sname="two"\/>/
    include_examples "global variable" , regex, message

    message = "class variable"
    regex = /\s+<globalVariableData\sname="three"\/>/
    include_examples "global variable" , regex, message

  end

  context "Global variable with assignment" do

    message = "instance global variable with value"
    regex = /\s+<globalVariableData\sname="five"\svalue="8"\/>/
    include_examples "global variable" , regex, message

    message = "class variable with value"
    regex = /\s+<globalVariableData\sname="eight"\svalue="'#'"\/>/
    include_examples "global variable" , regex, message

    message = "Normal global variable with value"
    regex = /\s+<globalVariableData\sname="four"\svalue="\[\]"\/>/
    include_examples "global variable" , regex, message

    message = "Assign an array with preset values"
    regex = /\s+<globalVariableData\sname="y"\svalue="\[1,2,3,4,5,6,8\]"\/>/
    include_examples "global variable" , regex, message

    message = "Assign an array with preset values, big string"
    regex = /\s+<globalVariableData\sname="yyyy"\svalue="\[1,2,3,4,5,6,8\]"\/>/
    include_examples "global variable" , regex, message
  end

  context "Global variable complex assignment" do
    message = "instance global variable with value"
    regex = /\s+<globalVariableData\sname="fourteen"\svalue="14 \+ 15"\/>/
    include_examples "global variable" , regex, message

    message = "class variable with value"
    regex = /\s+<globalVariableData\sname="thirteen"\svalue="2"\/>/
    include_examples "global variable" , regex, message

    message = "Normal global variable with value (ten)"
    regex = /\s+<globalVariableData\sname="ten"\svalue="'ten'"\/>/
    include_examples "global variable" , regex, message
  end

  context 'Global variable with $' do
    message = 'Real global variable with $ and value assignment'
    regex = /\s+<globalVariableData\sname="you"\svalue="3"\/>/
    include_examples 'global variable' , regex, message
  end

  context "Verify xml syntax" do
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
  end

  after :each do
    @kuniri = nil
    @output = nil
  end

end
