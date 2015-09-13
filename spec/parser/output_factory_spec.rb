require_relative '../spec_helper'

RSpec.describe Parser::OutputFactory do

  before :each do
    @outputFactory = Parser::OutputFactory.new
  end

  context "When have support to the parser." do

    it "XML support" do
      tmp = @outputFactory.get_output("xml")
      expect(tmp.is_a? (Parser::XMLOutputFormat) ).to be true
    end

  end

  context "When not have support to the parser." do

    it "YML support" do
      expect{@outputFactory.get_output("yml")}.to raise_error(
              Error::ParserError)

    end

  end

  after :each do
    @outputFactory = nil
  end

end
