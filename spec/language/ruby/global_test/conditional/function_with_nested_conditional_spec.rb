require_relative '../../../../spec_helper'

RSpec.describe Kuniri::Kuniri do

  before :each do
    @path = "./spec/language/ruby/global_test/conditional/.kuniri1.yml"
    @kuniri = Kuniri::Kuniri.new
    @kuniri.read_configuration_file(@path)
    @kuniri.run_analysis
    parser = Parser::XMLOutputFormat.new(@kuniri.configurationInfo[:output])
    parser.create_all_data(@kuniri.get_parser())
    @output = File.open("./spec/language/ruby/global_test/conditional/output1.xml", "r")
  end

  context "Simple cases of nested conditional" do
    it "First nested if (xpto)" do
      simpleIf = nil
      @output.each do |line|
        simpleIf = line =~ /\s+<if\sexpression="xpto == 'level0'"\slevel="0"\/?>/
        break unless simpleIf.nil?
      end
      expect(simpleIf).not_to be_nil
    end

    it "Second nested if (abc)" do
      simpleIf = nil
      @output.each do |line|
        simpleIf = line =~ /\s+<if\sexpression="abc == 'level1'"\slevel="1">\/?>/
        break unless simpleIf.nil?
      end
      expect(simpleIf).not_to be_nil
    end

    it "Third nested if (xyz)" do
      simpleIf = nil
      @output.each do |line|
        simpleIf = line =~ /\s+<if\sexpression="xyz == 'level0'"\slevel="0">\/?>/
        break unless simpleIf.nil?
      end
      expect(simpleIf).not_to be_nil

      simpleIf = nil
      @output.each do |line|
        simpleIf = line =~ /\s+<if\sexpression="abc == 'level1'" level="1"\/?>/
        break unless simpleIf.nil?
      end
      expect(simpleIf).not_to be_nil

      simpleIf = nil
      @output.each do |line|
        simpleIf = line =~ /\s+<else level="1"\/?>/
        break unless simpleIf.nil?
      end
      expect(simpleIf).not_to be_nil

    end
  end

  #context "Second cases of nested conditional" do

  #  it "" do
  #    simpleIf = nil
  #    @output.each do |line|
  #      simpleIf = line =~ /\s+<\/if>/
  #      break unless simpleIf.nil?
  #    end
  #    expect(simpleIf).not_to be_nil
  #  end

  #  it "" do
  #    simpleIf = nil
  #    @output.each do |line|
  #      simpleIf = line =~ /\s+<else level="0"\/?>/
  #      break unless simpleIf.nil?
  #    end
  #    expect(simpleIf).not_to be_nil
  #  end
  #end

  after :each do
    @kuniri = nil
    @output = nil
  end

end
