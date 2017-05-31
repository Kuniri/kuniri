require_relative '../../../spec_helper.rb'

RSpec.describe "Function counters" do

  before :each do
    @outputFormat = Parser::XMLOutputFormat.new
    @stringHeader = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
  end

  context "Counts methods using XMLOutputFormat" do
    it "::Counts methods" do
      expectedString = @stringHeader
      expectedString += "<totalGlobalFunctions counter=\"3\"/>\n"
      expectedString += "<functionData name=\"func1\" visibility=\"public\">\n"
      expectedString += "</functionData>\n"
      expectedString += "<functionData name=\"func2\" visibility=\"public\">\n"
      expectedString += "</functionData>\n"
      expectedString += "<functionData name=\"func3\" visibility=\"public\">\n"
      expectedString += "</functionData>\n"

      fileTmp = Languages::FileElementData.new("Xpto")
      (1..3).each {|i|
        fileTmp.add_global_function(Languages::FunctionData.new("func#{i}"))
      }
      @outputFormat.handle_element(fileTmp)
      expect(@outputFormat.outputEngine.to_xml).to eq(expectedString)
    end
  end
end