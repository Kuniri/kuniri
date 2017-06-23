require_relative '../../../../spec_helper'

RSpec.describe Kuniri::Kuniri do

  before :all do
    @path = "./spec/language/ruby/global_test/conditional/.kuniri.yml"
    @kuniri = Kuniri::Kuniri.new
    @kuniri.read_configuration_file(@path)
    @kuniri.run_analysis
    parser = Parser::XMLOutputFormat.new(0, @kuniri.configurationInfo[:output])
    parser.create_all_data(@kuniri.get_parser())
    target = "./spec/language/ruby/global_test/conditional/output.xml"
    @output = File.open(target, "r").read.split("\n")
  end

  RSpec.shared_examples "Function with conditional" do |regex, description|
    it "Method: #{description}" do
      conditional = nil
      @output.each do |line|
        conditional = line =~ regex
        break unless conditional.nil?
      end
      expect(conditional).not_to be_nil
    end
  end

  context "Simple cases of conditional" do

    message = "Should have simple if"
    regex = /\s+<if\sexpression="x == 99" level="0"\/?>/
    include_examples "Function with conditional" , regex, message

    message = "Should have simple if else"
    regex = /\s+<if\sexpression="x == 47" level="0"\/?>/
    include_examples "Function with conditional" , regex, message

    message = "Else conditional"
    regex = /\s+<else level="0"\/?>/
    include_examples "Function with conditional" , regex, message

    message = "Should have simple if and elsif"
    regex = /\s+<if\sexpression="x == 555"\slevel="0"\/?>/
    include_examples "Function with conditional" , regex, message

    message = "Find: elsif x == 777"
    regex = /\s+<elsif\sexpression="x == 777"\slevel="0"\/?>/
    include_examples "Function with conditional" , regex, message

    message = "Find: elsif x == 777"
    regex = /\s+<elsif\sexpression="x == 111"\slevel="0"\/?>/
    include_examples "Function with conditional" , regex, message

    message = "Find: if xpto == 778"
    regex = /\s+<if\sexpression="xpto == 778"\slevel="0"\/?>/
    include_examples "Function with conditional" , regex, message

    message = "Find: if xpto == 778"
    regex = /\s+<elsif\sexpression="abc == 555"\slevel="0"\/?>/
    include_examples "Function with conditional" , regex, message

    message = "Find: elsif asdf == 'a'"
    regex = /\s+<elsif\sexpression="asdf == 'a'"\slevel="0"\/?>/
    include_examples "Function with conditional" , regex, message

    message = "Find: else"
    regex = /\s+<else\slevel="0"\/?>/
    include_examples "Function with conditional" , regex, message

  end

  context "Verify open and close xml" do
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

  after :all do
    @kuniri = nil
    @output = nil
  end

end
