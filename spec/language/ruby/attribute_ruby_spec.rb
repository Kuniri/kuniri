require_relative '../../spec_helper'

RSpec.describe Languages::Ruby::AttributeRuby do

  before :all do
    @rubyAttr = Languages::Ruby::AttributeRuby.new
    @singleResult = 'value'
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

  context 'When multiple declarations with comma' do

    include Helpers

    before :all do
      @input = multiResult.map { |variable| '@' + variable.to_s }.join(', ')
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
  end

  context 'Multiple declaration with assignments' do

    include Helpers

    it 'All elements with values and separted by comma' do
      input = multiResult.map do |variable|
        space1 = Faker::Boolean.boolean ? ' ' * Faker::Number.between(1, 2) : ''
        space2 = Faker::Boolean.boolean ? ' ' * Faker::Number.between(1, 2) : ''
        number = Faker::Number.between(1, 5)
        value = Faker::Number.number(number)
        '@' + variable.to_s + space1 + '=' + space2 + value
      end.join(', ')
      multiple_declarations_verify(input)
    end

    it 'Partial assigments' do
      input = multiResult.map do |variable|
        space1 = Faker::Boolean.boolean ? ' ' * Faker::Number.between(1, 2) : ''
        space2 = Faker::Boolean.boolean ? ' ' * Faker::Number.between(1, 2) : ''
        number = Faker::Number.between(1, 5)
        value = Faker::Number.number(number)
        assigment = space1 + '=' + space2 + value
        '@' + variable.to_s + (Faker::Boolean.boolean ? assigment : '')
      end.join(', ')
      multiple_declarations_verify(input)
    end
  end

  context ' Multiple declaration with equal' do

    include Helpers

    before :all do
      @input = multiResult.map { |variable| '@' + variable.to_s }.join(' = ')
      @input = @input + ' = ' + Faker::Number.between(1, 200).to_s
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

  context 'Mixed of multiple declaration with comma, equal, @ and value' do

    include Helpers

    it 'Declaration with equal and comma' do
      input = '@attribute1, @attribute2 = 12, @attribute3 = @attribute4 = 41'
      attrs = ['attribute1', 'attribute2', 'attribute3', 'attribute4']
      values = ['nothing', '12', '41', '41']
      verify_variable_and_value(input, attrs, values)
    end

    it 'Declaration with equal, comma, and spaces' do
      input = ' @attribute1,    @attribute2   = 12  ,     @attribute3 =   @attribute4 =     41'
      attrs = ['attribute1', 'attribute2', 'attribute3', 'attribute4']
      values = ['nothing', '12', '41', '41']
      verify_variable_and_value(input, attrs, values)
    end

    it 'Very mixed declaration with equal and comma' do
      input = '@attribute1, @attribute2 = 12, @attribute3 = @attribute4 = 41, @attribute5 = "another"'
      attrs = ['attribute1', 'attribute2', 'attribute3', 'attribute4', 'attribute5']
      values = ['nothing', '12', '41', '41', '"another"']
      verify_variable_and_value(input, attrs, values)
    end

  end

  context 'Declaration with attr_' do

    include Helpers

    it 'Simple declaration with attr_reader' do
      input = 'attr_reader :attribute1, :attribute2, :attribute3'
      attrs = ['attribute1', 'attribute2', 'attribute3']
      values = ['nothing', 'nothing', 'nothing']
      verify_variable_and_value(input, attrs, values)
    end

    it 'Simple declaration with attr_reader with spaces' do
      input = '   attr_reader   :attribute1    ,   :attribute2   , :attribute3   '
      attrs = ['attribute1', 'attribute2', 'attribute3']
      values = ['nothing', 'nothing', 'nothing']
      verify_variable_and_value(input, attrs, values)
    end

    it 'Simple declaration with attr_writter' do
      input = 'attr_writer :attribute1, :attribute2, :attribute3'
      attrs = ['attribute1', 'attribute2', 'attribute3']
      values = ['nothing', 'nothing', 'nothing']
      verify_variable_and_value(input, attrs, values)
    end

    it 'Simple declaration with attr_writter, with spaces' do
      input = 'attr_writer    :attribute1  ,   :attribute2 ,    :attribute3 '
      attrs = ['attribute1', 'attribute2', 'attribute3']
      values = ['nothing', 'nothing', 'nothing']
      verify_variable_and_value(input, attrs, values)
    end

    it 'Simple declaration with attr_accessor' do
      input = 'attr_accessor :attribute1, :attribute2, :attribute3'
      attrs = ['attribute1', 'attribute2', 'attribute3']
      values = ['nothing', 'nothing', 'nothing']
      verify_variable_and_value(input, attrs, values)
    end

    it 'Simple declaration with attr_accessor, with spaces' do
      input = ' attr_accessor    :attribute1 ,   :attribute2  ,  :attribute3  '
      attrs = ['attribute1', 'attribute2', 'attribute3']
      values = ['nothing', 'nothing', 'nothing']
      verify_variable_and_value(input, attrs, values)
    end
  end

  context 'Class variable' do

    include Helpers

    it 'Class variable without assigment' do
      input = '@@attribute1, @@attribute2'
      attrs = ['attribute1', 'attribute2']
      values = ['nothing', 'nothing']
      verify_variable_and_value(input, attrs, values)
    end

    it 'Class variable with assigment' do
      input = '@@attribute1 = "lala", @@attribute2 = 300'
      attrs = ['attribute1', 'attribute2']
      values = ['"lala"', '300']
      verify_variable_and_value(input, attrs, values)
    end

  end

  after :all do
    @rubyAttr = nil
  end
end
