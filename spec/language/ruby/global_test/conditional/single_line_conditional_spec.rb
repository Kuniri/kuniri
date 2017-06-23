require_relative '../../../../spec_helper'

RSpec.describe Kuniri::Kuniri do

  before :all do
    @path = './spec/language/ruby/global_test/conditional/.kuniri7.yml'
    @kuniri = Kuniri::Kuniri.new
    @kuniri.read_configuration_file(@path)
    @kuniri.run_analysis
    parser = Parser::XMLOutputFormat.new(0, @kuniri.configurationInfo[:output])
    parser.create_all_data(@kuniri.get_parser())
    target = './spec/language/ruby/global_test/conditional/output7.xml'
    @output = File.open(target, 'r').read.split("\n")
  end

  RSpec.shared_examples 'Single line' do |regex, description|
    it "Method: #{description}" do
      conditional = nil
      @output.each do |line|
        conditional = line =~ regex
        break unless conditional.nil?
      end
      expect(conditional).not_to be_nil
    end
  end

  context 'Simple cases of conditional' do

    message = 'Should have simple single line if'
    regex = /\s+<if\sexpression="pFunctionName\.nil\?\sor\s!pFunctionName\.is_a\?\sString" level="0"\/?>/
    include_examples 'Single line' , regex, message

    message = 'Should have unless comparing numbers'
    regex = /\s+<unless\sexpression="5\s&gt;\s10" level="0"\/?>/
    include_examples 'Single line' , regex, message

    message = 'Should have simple if and elsif'
    regex = /\s+<if\sexpression="300\s&gt;\svalue"\slevel="0"\/?>/
    include_examples 'Single line' , regex, message

    message = 'Should find ternary operation'
    regex = /\s+<ternary\sexpression="ternary\s=\s\(value\s&lt;\s300\)"\slevel="0"\/?>/
    include_examples 'Single line' , regex, message

    message = 'if condition with complex expression'
    regex = /\s+<if\sexpression="'a'\s&gt;\s'b'\sor\s'c'\s&lt;\svalue"\slevel="0"\/?>/
    include_examples "Single line" , regex, message

    message = 'Single line if inside function'
    regex = /\s+<if\sexpression="5\s&lt;\svalue"\slevel="0"\/?>/
    include_examples 'Single line' , regex, message

  end

  context 'Verify open and close xml' do
    it 'Should verify the opening-closing structure' do
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
