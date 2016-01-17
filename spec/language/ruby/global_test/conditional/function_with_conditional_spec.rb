require_relative '../../../../spec_helper'

RSpec.describe Kuniri::Kuniri do

  before :each do
    @path = "./spec/language/ruby/global_test/conditional/.kuniri.yml"
    @kuniri = Kuniri::Kuniri.new
    @kuniri.read_configuration_file(@path)
    @kuniri.run_analysis
    parser = Parser::XMLOutputFormat.new(@kuniri.configurationInfo[:output])
    parser.create_all_data(@kuniri.get_parser())
    @output = File.open("./spec/language/ruby/global_test/conditional/output.xml", "r")
  end

  context "Simple cases of conditional" do
    it "Should have simple if" do
      simpleIf = nil
      @output.each do |line|
        simpleIf = line =~ /\s+<if\sexpression="x == 99" level="0"\/?>/
        break unless simpleIf.nil?
      end
      expect(simpleIf).not_to be_nil
    end

    it "Should have simple if else" do
      simpleIfElse = nil
      @output.each do |line|
        simpleIfElse = line =~ /\s+<if\sexpression="x == 47" level="0"\/?>/
        break unless simpleIfElse.nil?
      end
      expect(simpleIfElse).not_to be_nil

      simpleIfElse = nil
      @output.each do |line|
        simpleIfElse = line =~ /\s+<else level="0"\/?>/
        break unless simpleIfElse.nil?
      end
      expect(simpleIfElse).not_to be_nil
    end

    it "Should have simple if and elsif" do
      simpleIfElsif = nil
      @output.each do |line|
        simpleIfElsif = line =~ /\s+<if\sexpression="x == 555"\slevel="0"\/?>/
        break unless simpleIfElsif.nil?
      end
      expect(simpleIfElsif).not_to be_nil

      simpleIfElsif = nil
      @output.each do |line|
        simpleIfElsif = line =~ /\s+<elsif\sexpression="x == 777"\slevel="0"\/?>/
        break unless simpleIfElsif.nil?
      end
      expect(simpleIfElsif).not_to be_nil

      simpleIfElsif = nil
      @output.each do |line|
        simpleIfElsif = line =~ /\s+<elsif\sexpression="x == 111"\slevel="0"\/?>/
        break unless simpleIfElsif.nil?
      end
      expect(simpleIfElsif).not_to be_nil
    end

    it "Should have simple if, elsif, and else" do
      simpleIfElsif = nil
      @output.each do |line|
        simpleIfElsif = line =~ /\s+<if\sexpression="xpto == 778"\slevel="0"\/?>/
        break unless simpleIfElsif.nil?
      end
      expect(simpleIfElsif).not_to be_nil

      simpleIfElsif = nil
      @output.each do |line|
        simpleIfElsif = line =~ /\s+<elsif\sexpression="abc == 555"\slevel="0"\/?>/
        break unless simpleIfElsif.nil?
      end
      expect(simpleIfElsif).not_to be_nil

      simpleIfElsif = nil
      @output.each do |line|
        simpleIfElsif = line =~ /\s+<elsif\sexpression="asdf == 'a'"\slevel="0"\/?>/
        break unless simpleIfElsif.nil?
      end
      expect(simpleIfElsif).not_to be_nil

      simpleIfElsif = nil
      @output.each do |line|
        simpleIfElsif = line =~ /\s+<else\slevel="0"\/?>/
        break unless simpleIfElsif.nil?
      end
      expect(simpleIfElsif).not_to be_nil

    end

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
