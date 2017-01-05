require_relative '../../spec_helper'

RSpec.describe Languages::Ruby::AttributeRuby do

  before :all do
    @rubyAttr = Languages::Ruby::AttributeRuby.new
    @singleResult = 'value'
    @multiResult = ['value1', 'value2', 'value3', 'value4']
  end

  context 'When is a single attribute with @' do
    it 'Simple case with @' do
      captured = @rubyAttr.get_attribute('@value')[0]
      expect(captured.name).to eq(@singleResult)
    end

    it 'Whitespace before' do
      captured = @rubyAttr.get_attribute('       @value')[0]
      expect(captured.name).to eq(@singleResult)
    end

    it 'Between whitespace' do
      captured = @rubyAttr.get_attribute('    @value  ')[0]
      expect(captured.name).to eq(@singleResult)
    end
  end

  context 'When is a single attribute with attr_' do
    it 'With attr_writer' do
      captured = @rubyAttr.get_attribute('attr_writer :value')[0]
      expect(captured.name).to eq(@singleResult)
    end

    it 'With attr_reader' do
      captured = @rubyAttr.get_attribute('attr_reader :value')[0]
      expect(captured.name).to eq(@singleResult)
    end

    it 'With attr_accessor' do
      captured = @rubyAttr.get_attribute('attr_accessor :value')[0]
      expect(captured.name).to eq(@singleResult)
    end

    it 'With whitespace before attr_writer' do
      captured = @rubyAttr.get_attribute('  attr_writer :value')[0]
      expect(captured.name).to eq(@singleResult)
    end

    it 'With whitespace before and after attr_reader' do
      captured = @rubyAttr.get_attribute('  attr_reader :value  ')[0]
      expect(captured.name).to eq(@singleResult)
    end

    it 'Typo attr_read instead of attr_reader' do
      captured = @rubyAttr.get_attribute('  attr_read :value  ')
      expect(captured).to eq(nil)
    end

    it 'Typo attr_write instead of attr_writer' do
      captured = @rubyAttr.get_attribute('  attr_write :value  ')
      expect(captured).to eq(nil)
    end

    it 'Typo attr_accesso instead of attr_accessor' do
      captured = @rubyAttr.get_attribute('  attr_accesso :value  ')
      expect(captured).to eq(nil)
    end

  end

  module Helpers
    def multiple_declarations_verify(input)
      listResult = []
      capturedList = @rubyAttr.get_attribute(input)
      capturedList.each do |element|
        listResult.push(element.name)
      end
      expect(listResult).to match_array(@multiResult)
    end

    def verify_variable_and_value(input, expectedAttributes, expectedValues)
      listOfValues = []
      listOfAttributes = []

      capturedList = @rubyAttr.get_attribute(input)
      capturedList.each do |element|
        listOfAttributes.push(element.name)
        listOfValues.push(element.value)
      end
      expect(listOfValues).to match_array(expectedValues)
      expect(listOfAttributes).to match_array(expectedAttributes)
    end
  end

  context 'When multiple declarations with comma' do

    include Helpers

    before :all do
      @input = '@value1, @value2, @value3, @value4'
    end

    it 'Use only one space' do
      multiple_declarations_verify(@input)
    end

    it 'Whitespace in the beginning' do
      multiple_declarations_verify('     ' + @input)
    end

    it 'Whitespace in the end' do
      multiple_declarations_verify(@input + '     ')
    end

    it 'Whitespace in the beginning and in the end' do
      multiple_declarations_verify('  ' + @input + ' ')
    end

    it 'White space after comma' do
      multiple_declarations_verify(@input.gsub(/,/, ', '))
    end

    it 'Whitespace before and after comma' do
      multiple_declarations_verify(@input.gsub(/,/, ' , '))
    end

    it 'Many whitespace before and after comma' do
      multiple_declarations_verify(@input.gsub(/,/, '   ,   '))
    end

    it 'Multiple declaration with assignment' do
      input = '@value1 = 3, @value2 = 1, @value3 = 324, @value4=28'
      multiple_declarations_verify(input)
    end

    it 'Partial Assignment' do
      input = '@value1 = 3, @value2 = 1, @value3, @value4=28'
      multiple_declarations_verify(input)
    end
 end

  context ' Multiple declaration with equal' do

    include Helpers

    before :all do
      @input = '@value1 = @value2 = @value3 = @value4 = 3'
    end

    it 'Separated by equal' do
      multiple_declarations_verify(@input)
    end

    it 'Whitespace in the beginning' do
      multiple_declarations_verify('      ' + @input)
    end

    it 'Whitespace in the end' do
      multiple_declarations_verify(@input + '          ')
    end

    it 'Whitespace in before and after the input' do
      multiple_declarations_verify('       ' + @input)
    end

    it 'Whitespace between equal' do
      multiple_declarations_verify(@input.gsub(/=/, "   =  "))
    end
  end

  context 'When is a single attribute with @ and value' do

    include Helpers

    it 'Simple number assignment without spaces' do
      input = '@attribute = 13'
      attrs = ['attribute']
      values = ['13']
      verify_variable_and_value(input, attrs, values)
    end

    it 'Simple number assignment with spaces' do
      input = '  @attribute    =  12  '
      attrs = ['attribute']
      values = ['12']
      verify_variable_and_value(input, attrs, values)
    end

    it 'Simple string assignment without spaces' do
      input = '  @attribute    =  "test one"  '
      attrs = ['attribute']
      values = ['"test one"']
      verify_variable_and_value(input, attrs, values)
    end

    it 'Simple string assignment with spaces' do
      input = '  @attribute         =  "test one"  '
      attrs = ['attribute']
      values = ['"test one"']
      verify_variable_and_value(input, attrs, values)
    end

    it 'Simple array of number assignment without spaces' do
      input = '@attribute = [1,2,3,4,5,6,7,9,10,11,12]'
      attrs = ['attribute']
      values = ['[1,2,3,4,5,6,7,9,10,11,12]']
      verify_variable_and_value(input, attrs, values)
    end

    it 'Simple array of number assignment with spaces' do
      input = ' @attribute   =     [1,2,3,4,5,   6,7,9,10   ,  11,12]    '
      attrs = ['attribute']
      values = ['[1,2,3,4,5,6,7,9,10,11,12]']
      verify_variable_and_value(input, attrs, values)
    end

    it 'Simple array of strings assignment without spaces' do
      input = '@attribute = ["one","two","three"]'
      attrs = ['attribute']
      values = ['["one","two","three"]']
      verify_variable_and_value(input, attrs, values)
    end

    it 'Simple array of strings assignment with spaces' do
      input = '    @attribute      =    [ "one", "two","three"]   '
      attrs = ['attribute']
      values = ['["one","two","three"]']
      verify_variable_and_value(input, attrs, values)
    end

    it 'Simple array of strings and numbers without spaces' do
      input = '@attribute = ["one", 2, "three", 4, 5]'
      attrs = ['attribute']
      values = ['["one",2,"three",4,5]']
      verify_variable_and_value(input, attrs, values)
    end

    it 'Simple hash without spaces' do
      input = '@attribute = {"one" => 1, "two" =>2, "three" => "tres"}'
      attrs = ['attribute']
      values = ['{"one"=>1,"two"=>2,"three"=>"tres"}']
      verify_variable_and_value(input, attrs, values)
    end

    it 'Simple hash with spaces' do
      input = ' @attribute   =   {"one" =>  1, "two" =>2,"three" =>   "tres"}  '
      attrs = ['attribute']
      values = ['{"one"=>1,"two"=>2,"three"=>"tres"}']
      verify_variable_and_value(input, attrs, values)
    end

    it 'Simple hash with array' do
      input = '@attribute = {"one" => [1,2,3,4], "two" =>2}'
      attrs = ['attribute']
      values = ['{"one"=>[1,2,3,4],"two"=>2}']
      verify_variable_and_value(input, attrs, values)
    end

    it 'Simple assignment with fuction as a value and without spaces' do
      input = '@attribute = Xpto.doTheMagic()'
      attrs = ['attribute']
      values = ['Xpto.doTheMagic()']
      verify_variable_and_value(input, attrs, values)
    end

    it 'Simple assignment with fuction as a value and with spaces' do
      input = '   @attribute   =     Xpto.doTheMagic ()   '
      attrs = ['attribute']
      values = ['Xpto.doTheMagic ()']
      verify_variable_and_value(input, attrs, values)
    end

  end

  context 'When is a multiple attribute separated by =, with @ and value' do

    include Helpers

    it 'Assignment with number and without spaces' do
      input = '@attribute1 = @attribute2 = 13'
      attrs = ['attribute1', 'attribute2']
      values = ['13', '13']
      verify_variable_and_value(input, attrs, values)
    end

    it 'Assignment with number and with spaces' do
      input = '     @attribute1    =      @attribute2    =     13  '
      attrs = ['attribute1', 'attribute2']
      values = ['13', '13']
      verify_variable_and_value(input, attrs, values)
    end

    it 'Assignment with number, without spaces and a lot of variables' do
      input = '@attribute1 = @attribute2 = @attribute3 = @attribute4 = 13'
      attrs = ['attribute1', 'attribute2', 'attribute3', 'attribute4']
      values = ['13', '13', '13', '13']
      verify_variable_and_value(input, attrs, values)
    end

    it 'Assignment with strings and without spaces' do
      input = '@attribute1 = @attribute2 = "test one"'
      attrs = ['attribute1', 'attribute2']
      values = ['"test one"', '"test one"']
      verify_variable_and_value(input, attrs, values)
    end

    it 'Assignment with strings and with spaces' do
      input = ' @attribute1      =       @attribute2   =     "test one"  '
      attrs = ['attribute1', 'attribute2']
      values = ['"test one"', '"test one"']
      verify_variable_and_value(input, attrs, values)
    end

    it 'Assignment with array of number and without spaces' do
      input = '@attribute1 = @attribute2 = [1,2,3]'
      attrs = ['attribute1', 'attribute2']
      values = ['[1,2,3]', '[1,2,3]']
      verify_variable_and_value(input, attrs, values)
    end

    it 'Assignment with array of number and with spaces' do
      input = ' @attribute1     =    @attribute2    =    [1,2,3]  '
      attrs = ['attribute1', 'attribute2']
      values = ['[1,2,3]', '[1,2,3]']
      verify_variable_and_value(input, attrs, values)
    end

    it 'Assignment with array of strings and without spaces' do
      input = '@attribute1 = @attribute2 = ["one","two"]'
      attrs = ['attribute1', 'attribute2']
      values = ['["one","two"]', '["one","two"]']
      verify_variable_and_value(input, attrs, values)
    end

    it 'Assignment with array of strings and with spaces' do
      input = ' @attribute1 =      @attribute2 =    ["one","two"]   '
      attrs = ['attribute1', 'attribute2']
      values = ['["one","two"]', '["one","two"]']
      verify_variable_and_value(input, attrs, values)
    end

    it 'Assignment with array of strings, values and without spaces' do
      input = '@attribute1 = @attribute2 = ["one","two", 3, 4]'
      attrs = ['attribute1', 'attribute2']
      values = ['["one","two",3,4]', '["one","two",3,4]']
      verify_variable_and_value(input, attrs, values)
    end

    it 'Assignment with hash without spaces' do
      input = '@attribute1 = @attribute2 = {"one"=>1,"two"=>2, "t"=>3, "f"=>4}'
      attrs = ['attribute1', 'attribute2']
      values = ['{"one"=>1,"two"=>2,"t"=>3,"f"=>4}', '{"one"=>1,"two"=>2,"t"=>3,"f"=>4}']
      verify_variable_and_value(input, attrs, values)
    end

  end

  context 'When is a multiple attribute separated by comma, with @ and value' do

    include Helpers

    it 'Multiple attributes without assignment' do
      input = '@attribute1, @attribute2, @attribute3, @attribute4'
      attrs = ['attribute1', 'attribute2', 'attribute3', 'attribute4']
      values = ['nothing', 'nothing', 'nothing', 'nothing']
      verify_variable_and_value(input, attrs, values)
    end

    it 'Multiple attributes without assignment and with spaces' do
      input = '  @attribute1,   @attribute2 ,  @attribute3 ,   @attribute4   '
      attrs = ['attribute1', 'attribute2', 'attribute3', 'attribute4']
      values = ['nothing', 'nothing', 'nothing', 'nothing']
      verify_variable_and_value(input, attrs, values)
    end

    it 'Multiple attributes with number assignment' do
      input = '@attribute1 = 1, @attribute2=234,@attribute3 = 41, @attribute4=3'
      attrs = ['attribute1', 'attribute2', 'attribute3', 'attribute4']
      values = ['1', '234', '41', '3']
      verify_variable_and_value(input, attrs, values)
    end

    it 'Multiple attributes with number assignment with spaces' do
      input = '   @attribute1 = 1, @attribute2=    234 ,   @attribute3 = 41, @attribute4     =3   '
      attrs = ['attribute1', 'attribute2', 'attribute3', 'attribute4']
      values = ['1', '234', '41', '3']
      verify_variable_and_value(input, attrs, values)
    end

    it 'Multiple attributes with strings assignment' do
      input = '@attribute1 = "xpto", @attribute2 = "me", @attribute3 = "ruby", @attribute4 = "Kuniri"'
      attrs = ['attribute1', 'attribute2', 'attribute3', 'attribute4']
      values = ['"xpto"', '"me"', '"ruby"', '"Kuniri"']
      verify_variable_and_value(input, attrs, values)
    end

    it 'Multiple attributes with strings assignment with spaces' do
      input = '   @attribute1    =    "xpto", @attribute2  =    "me"   , @attribute3 =  "ruby",@attribute4 =  "Kuniri" '
      attrs = ['attribute1', 'attribute2', 'attribute3', 'attribute4']
      values = ['"xpto"', '"me"', '"ruby"', '"Kuniri"']
      verify_variable_and_value(input, attrs, values)
    end

    it 'Multiple attributes with strings assignment and numbers' do
      input = '@attribute1 = "xpto", @attribute2 = 41, @attribute3 = "ruby", @attribute4 = 390'
      attrs = ['attribute1', 'attribute2', 'attribute3', 'attribute4']
      values = ['"xpto"', '41', '"ruby"', '390']
      verify_variable_and_value(input, attrs, values)
    end

    it 'Without assigment and with a number assigment' do
      input = '@attribute1, @attribute2 = 12'
      attrs = ['attribute1', 'attribute2']
      values = ['nothing', '12']
      verify_variable_and_value(input, attrs, values)
    end
  end

  after :all do
    @rubyAttr = nil
  end
end
