require_relative '../spec_helper'

RSpec.describe Parser::Parser do

  before :each do
    @filesProject = Dir[File.join("./", "**", "**.rb")]
    @parser = Parser::Parser.new(@filesProject)
  end

  context "When start, find all the ruby files" do
    it "Always get a list" do
      expect(@parser.fileLanguage).to eq([])
    end

    it "Total of files to parse" do
      @parser.start_parser
      expect(@parser.fileLanguage.size).to eq(@filesProject.size)
    end

    it "Try a empty file path" do
      @filesProject = ""
      @parser = Parser::Parser.new(@filesProject)
      expect{@parser.start_parser}.to raise_error(
        Error::ConfigurationFileError)
    end
  end

  after :each do
    @parser = nil
  end

end
