require_relative '../../../../spec_helper'

RSpec.describe Kuniri::Kuniri do

  before :all do
    @path = './spec/language/ruby/global_test/constructor/.kuniri1.yml'
    @kuniri = Kuniri::Kuniri.new
    @kuniri.read_configuration_file(@path)
    @kuniri.run_analysis
    parser = Parser::XMLOutputFormat.new(0, @kuniri.configurationInfo[:output])
    parser.create_all_data(@kuniri.get_parser())
    target = './spec/language/ruby/global_test/constructor/different_constructors.xml'
    @output = File.open(target, 'r').read.split("\n")
  end

  RSpec.shared_examples 'Constructor verification' do |regex, description|
    it " : #{description}" do
      variable = nil
      @output.each do |line|
        variable = line =~ regex
        break unless variable.nil?
      end
      expect(variable).not_to be_nil
    end
  end

  context 'Simple cases of constructor with methods' do

    message = 'Should find only one constructor'
    regex = /\s+<constructorData\sname="initialize"\svisibility="public"\/?>/
    include_examples 'Constructor verification', regex, message

    message = 'Should find normal methods: bla'
    regex = /\s+<methodData\sname="bla"\svisibility="public"\/?>/
    include_examples 'Constructor verification', regex, message

    message = 'Should find normal methods: initialize_fake'
    regex = /\s+<methodData\sname="initialize_fake"\svisibility="public"\/?>/
    include_examples 'Constructor verification', regex, message

    message = 'Should find normal methods: initialize_variable'
    regex = /\s+<methodData\sname="initialize_variable"\svisibility="public"\/?>/
    include_examples 'Constructor verification', regex, message

    message = 'Should find normal methods: initialize_something'
    regex = /\s+<methodData\sname="initialize_something"\svisibility="public"\/?>/
    include_examples 'Constructor verification', regex, message

    message = 'Should find normal methods: hey_initialize'
    regex = /\s+<methodData\sname="hey_initialize"\svisibility="public"\/?>/
    include_examples 'Constructor verification', regex, message

    message = 'Should find normal methods: hey_initialize_2'
    regex = /\s+<methodData\sname="hey_initialize_2"\svisibility="public"\/?>/
    include_examples 'Constructor verification', regex, message
  end

  context 'Verify xml syntax' do
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
