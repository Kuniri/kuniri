require_relative '../../../../spec_helper'

RSpec.describe 'Simple blocks as a script' do

  before :each do
    @path = './spec/language/ruby/global_test/blocks/.kuniri.yml'
    @kuniri = Kuniri::Kuniri.new
    @kuniri.read_configuration_file(@path)
    @kuniri.run_analysis
    parser = Parser::XMLOutputFormat.new(0, @kuniri.configurationInfo[:output])
    parser.create_all_data(@kuniri.get_parser())
    target = './spec/language/ruby/global_test/blocks/simple_block_script.xml'
    @output = File.open(target, 'r')
  end

  RSpec.shared_examples 'Block verification' do |regex, description|

    it "Global Function: #{description}" do
      mixElement = nil
      @output.each do |line|
        mixElement = line =~ regex
        break unless mixElement.nil?
      end
      expect(mixElement).not_to be_nil
    end

  end

  context 'Test simple block' do

    message = 'Find times as an expression'
    regex = /\s*<block\sexpression="TIMES"\slevel="0"\/?>/
    include_examples 'Block verification' , regex, message

    message = 'Find each as an expression'
    regex = /\s*<block\sexpression="EACH"\slevel="0"\/?>/
    include_examples 'Block verification' , regex, message

    message = 'Find conditional inside block'
    regex = /\s*<if\sexpression="theValue\s==\s3"\slevel="1"\/?>/
    include_examples 'Block verification' , regex, message

    message = 'Find map as an expression'
    regex = /\s*<block\sexpression="MAP"\slevel="0"\/?>/
    include_examples 'Block verification' , regex, message

  end

  after :each do
    @kuniri = nil
    @output = nil
  end

end
