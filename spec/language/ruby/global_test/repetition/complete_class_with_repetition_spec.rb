require_relative '../../../../spec_helper'

# TODO: You have to refectory it!

RSpec.describe Kuniri::Kuniri do

  before :each do
    @kuniri = Kuniri::Kuniri.new
  end

  context "Validate for loop" do
    it "Check for statement" do
      path = "./spec/language/ruby/global_test/repetition/.kuniri4.yml"
      @kuniri.read_configuration_file(path)
      @kuniri.run_analysis
      parser = Parser::XMLOutputFormat.new(@kuniri.configurationInfo[:output])
      parser.create_all_data(@kuniri.get_parser())
      @output = File.open("./spec/language/ruby/global_test/repetition/forLoopInClass.xml", "r")

      @method_name = nil
      @output.each do |line|
        @method_name = line =~
        /\s+<for\sexpression="i in 0..5" level="0"\/>/
        break unless @method_name.nil?
      end
      expect(@method_name).not_to be_nil
    end
  end

  context "Validate while loop" do
    it "Check while statement" do
      path = "./spec/language/ruby/global_test/repetition/.kuniri2.yml"
      @kuniri.read_configuration_file(path)
      @kuniri.run_analysis
      parser = Parser::XMLOutputFormat.new(@kuniri.configurationInfo[:output])
      parser.create_all_data(@kuniri.get_parser())
      @output = File.open("./spec/language/ruby/global_test/repetition/whileLoopInClass.xml", "r")

      @method_name = nil
      @output.each do |line|
        @method_name = line =~
        /\s+<while\sexpression="\$i &lt; \$num" level="0"\/>/
        break unless @method_name.nil?
      end
      expect(@method_name).not_to be_nil
    end
  end

  context "Validate until loop" do
    it "Check until statement" do
      path = "./spec/language/ruby/global_test/repetition/.kuniri3.yml"
      @kuniri.read_configuration_file(path)
      @kuniri.run_analysis
      parser = Parser::XMLOutputFormat.new(@kuniri.configurationInfo[:output])
      parser.create_all_data(@kuniri.get_parser())
      @output = File.open("./spec/language/ruby/global_test/repetition/untilInClass.xml", "r")

      @method_name = nil
      @output.each do |line|
        @method_name = line =~
        /\s+<until\sexpression="\$i &gt; \$num" level="0"\/>/
        break unless @method_name.nil?
      end
      expect(@method_name).not_to be_nil
    end
  end


  context "Verify output integrity" do
    it "Repetition: verify the opening-closing structure" do
      path = "./spec/language/ruby/global_test/repetition/.kuniri.yml"
      @kuniri.read_configuration_file(path)
      @kuniri.run_analysis
      parser = Parser::XMLOutputFormat.new(@kuniri.configurationInfo[:output])
      parser.create_all_data(@kuniri.get_parser())
      @output = File.open("./spec/language/ruby/global_test/repetition/forLoopInClass.xml", "r")

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
  end

end
