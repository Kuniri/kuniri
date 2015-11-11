require_relative '../spec_helper'

RSpec.describe Parser::XMLBuilderEngine do

  before :each do
    @builder = Parser::XMLBuilderEngine.new
    @basicHeader = '<?xml version="1.0" encoding="UTF-8"?>'
  end

  context "Default options" do
    it "Nothing" do
      tag = @builder.to_xml
      expect(tag).to eq(@basicHeader)
    end

    it "Reset" do
      @builder.reset_engine
      tag = @builder.to_xml
      expect(tag).to eq(@basicHeader)
    end
  end

  context "Generate class" do
    it "Generate simple class" do
      @builder.kuniri do
        classData :name => "Xpto", :visibility => "public" do
        end
      end
      output = [@basicHeader,
                '<kuniri>',
                '  <classData name="Xpto" visibility="public">',
                '  </classData>',
                '</kuniri>'].join("\n") + "\n"
      expect(@builder.to_xml).to eq(output)
    end

    it "Generate simple class with inheritance" do
      @builder.kuniri do
        classData :name => "Xpto", :visibility => "public" do
          inheritanceData :name => "Abc"
        end
      end

      output = [@basicHeader,
                '<kuniri>',
                '  <classData name="Xpto" visibility="public">',
                '    <inheritanceData name="Abc"/>',
                '  </classData>',
                '</kuniri>'].join("\n") + "\n"
      expect(@builder.to_xml).to eq(output)
    end

    it "Class with attribute" do
      @builder.kuniri do
        classData :name => "Xpto", :visibility => "public" do
          attributeData :name => "abc", :visibility => "public"
        end
      end

      output = [@basicHeader,
                '<kuniri>',
                '  <classData name="Xpto" visibility="public">',
                '    <attributeData name="abc" visibility="public"/>',
                '  </classData>',
                '</kuniri>'].join("\n") + "\n"
      expect(@builder.to_xml).to eq(output)
    end

    it "Class with constructor" do
      @builder.kuniri do
        classData :name => "Xpto", :visibility => "public" do
          constructorData :name => "initialize", :visibility => "public" do
          end
        end
      end

      output = [@basicHeader,
                '<kuniri>',
                '  <classData name="Xpto" visibility="public">',
                '    <constructorData name="initialize" visibility="public">',
                '    </constructorData>',
                '  </classData>',
                '</kuniri>'].join("\n") + "\n"
      expect(@builder.to_xml).to eq(output)
    end

    it "Class with method" do
      @builder.kuniri do
        classData :name => "Xpto", :visibility => "public" do
          methodData :name => "abc", :visibility => "public" do
          end
        end
      end

      output = [@basicHeader,
                '<kuniri>',
                '  <classData name="Xpto" visibility="public">',
                '    <methodData name="abc" visibility="public">',
                '    </methodData>',
                '  </classData>',
                '</kuniri>'].join("\n") + "\n"
      expect(@builder.to_xml).to eq(output)
    end
  end

  context "Conditional and repetition statement" do
    it "If statement" do
      @builder.kuniri do
        classData :name => "Xpto", :visibility => "public" do
          methodData :name => "abc", :visibility => "public" do
            conditionalData :type => "if",
                            :expression => "x > 2"
          end
        end
      end

      output = [@basicHeader,
                '<kuniri>',
                '  <classData name="Xpto" visibility="public">',
                '    <methodData name="abc" visibility="public">',
                '      <conditionalData type="if" expression="x > 2"/>',
                '    </methodData>',
                '  </classData>',
                '</kuniri>'].join("\n") + "\n"
      expect(@builder.to_xml).to eq(output)
    end

    it "Unless statement" do
      @builder.kuniri do
        classData :name => "Xpto", :visibility => "public" do
          methodData :name => "abc", :visibility => "public" do
            conditionalData :type => "unless",
                            :expression => "(abc > 3) && (kto < 20)"
          end
        end
      end

      output = [@basicHeader,
                '<kuniri>',
                '  <classData name="Xpto" visibility="public">',
                '    <methodData name="abc" visibility="public">',
                '      <conditionalData type="unless" expression="(abc > 3) && (kto < 20)"/>',
                '    </methodData>',
                '  </classData>',
                '</kuniri>'].join("\n") + "\n"
      expect(@builder.to_xml).to eq(output)
    end

  end

  context "Global function" do
    it "Simple global function" do
      @builder.kuniri do
        functionData :name => "xpto", :visibility => "global" do
        end
      end

      output = [@basicHeader,
                '<kuniri>',
                '  <functionData name="xpto" visibility="global">',
                '  </functionData>',
                '</kuniri>'].join("\n") + "\n"
      expect(@builder.to_xml).join("\n") + "\n"
    end

    it "Global function with conditional" do
      @builder.kuniri do
        functionData :name => "xpto", :visibility => "global" do
          conditionalData :type => "if", :expression => "u == 5"
        end
      end

      output = [@basicHeader,
                '<kuniri>',
                '  <functionData name="xpto" visibility="global">',
                '    <conditionalData type="if" expression="u == 5"/>',
                '  </functionData>',
                '</kuniri>'].join("\n") + "\n"
      expect(@builder.to_xml).to eq(output)
    end

    it "Global function with repetition" do
      @builder.kuniri do
        functionData :name => "xpto", :visibility => "global" do
          repetitionData :type => "while", :expression => "(x < 0)"
        end
      end

      output = [@basicHeader,
                '<kuniri>',
                '  <functionData name="xpto" visibility="global">',
                '   <repetitionData type="while" expression="(x < 0)"/>',
                '  </functionData>',
                '</kuniri>',].join("\n") + "\n"
      expect(@builder.to_xml).to eq(output)
    end

    it "Global function with parameters" do
      @builder.kuniri do
        functionData :name => "xpto", :visibility => "global" do
          parameterData :name => "one"
        end
      end

      output = [@basicHeader,
                '<kuniri>',
                '  <functionData name="xpto" visibility="global">',
                '    <parameterData name="one"/>',
                '  </functionData>',
                '</kuniri>'].join("\n") + "\n"
      expect(@builder.to_xml).to eq(output)
    end

    it "Full global function" do
      @builder.kuniri do
        functionData :name => "xpto", :visibility => "global" do
          parameterData :name => "two"
          conditionalData :type => "if", :expression => "y == x"
          repetitionData :type => "while", :expression => "k and y"
        end
      end

      output = [@basicHeader,
                '<kuniri>',
                '  <functionData name="xpto" visibility="global">',
                '    <parameterData name="two"/>',
                '    <conditionalData type="if" expression="y == x"/>',
                '    <repetitionData type="while" expression="k and y"/>',
                '  </functionData>',
                '</kuniri>'].join("\n") + "\n"
      expect(@builder.to_xml).to eq(output)
    end

  end

  context "Global variable" do
    it "Simple global variable" do
      @builder.kuniri do
        globalVariableData :name => "xpto"
      end

      output = [@basicHeader,
                '<kuniri>',
                '  <globalVariableData name="xpto"/>',
                '</kunri>'].join("\n") + "\n"
      expect(@builder.to_xml).to eq(output)
    end
  end

#  context "Extern requirements" do
#  end

  after :each do
    @builder = nil
  end

end
