require_relative '../../../../spec_helper.rb'

RSpec.describe "Method counters" do

  before :each do
    @outputFormat = Parser::XMLOutputFormat.new
    @stringHeader = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
  end

  context "Counts methods using XMLOutputFormat" do
    it "::Counts methods" do
      expectedString = @stringHeader
      expectedString += "<classData name=\"Xpto\" visibility=\"public\">\n"
      expectedString += "  <constructorData name=\"Aconstructor\" visibility=\"public\">\n"
      expectedString += "  </constructorData>\n"
      expectedString += "  <methodData name=\"meth1\" visibility=\"public\">\n"
      expectedString += "  </methodData>\n"
      expectedString += "  <methodData name=\"meth2\" visibility=\"public\">\n"
      expectedString += "  </methodData>\n"
      expectedString += "  <methodData name=\"meth3\" visibility=\"public\">\n"
      expectedString += "  </methodData>\n"
      expectedString += "  <totalMethods counter=\"3\"/>\n"
      expectedString += "</classData>\n"
      classTmp = Languages::ClassData.new
      classTmp.name = "Xpto"
      (1..3).each {|i|
        classTmp.add_method(Languages::MethodData.new("meth#{i}"))
      }
      classTmp.add_constructor(Languages::ConstructorData.new("Aconstructor"))
      @outputFormat.class_generate([classTmp])
      expect(@outputFormat.outputEngine.to_xml).to eq(expectedString)
    end
  end
end