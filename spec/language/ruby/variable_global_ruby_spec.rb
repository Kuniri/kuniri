require_relative '../../spec_helper'

RSpec.describe Languages::Ruby::VariableGlobalRuby do

  before :all do
    @variableRuby = Languages::Ruby::VariableGlobalRuby.new
  end

  context 'Single variable without assigments' do

    include Helpers

    it 'Capture simple variable without assigment' do
      input = 'variable1'
      variables = ['variable1']
      values = ['nothing']
      verify_variable_and_value(input, variables, values, false)
    end

    it 'Capture simple variable without assigment and with spaces' do
      input = '    variable1        '
      variables = ['variable1']
      values = ['nothing']
      verify_variable_and_value(input, variables, values, false)
    end

    it 'Capture simple variable with $' do
      input = '$variable'
      variables = ['variable']
      values = ['nothing']
      verify_variable_and_value(input, variables, values, false)
    end

    it 'Capture simple variable with $ and spaces' do
      input = '  $variable    '
      variables = ['variable']
      values = ['nothing']
      verify_variable_and_value(input, variables, values, false)
    end

    it 'Capture simple variable with @@' do
      input = '@@variable'
      variables = ['variable']
      values = ['nothing']
      verify_variable_and_value(input, variables, values, false)
    end

    it 'Capture simple variable with @@ and spaces' do
      input = '  @@variable    '
      variables = ['variable']
      values = ['nothing']
      verify_variable_and_value(input, variables, values, false)
    end
  end

  context 'Single variable with assigments' do

    include Helpers

    it 'Capture simple variable.' do
      input = 'one = 1'
      variables = ['one']
      values = ['1']
      verify_variable_and_value(input, variables, values, false)
    end

    it 'Capture simple variable with spaces and number assigment' do
      input = '   two = 2'
      variables = ['two']
      values = ['2']
      verify_variable_and_value(input, variables, values, false)
    end

    it 'Capture simple variable without spaces and string assigment' do
      input = 'three = "three_value"'
      variables = ['three']
      values = ['"three_value"']
      verify_variable_and_value(input, variables, values, false)
    end

    it 'Capture simple variable with spaces and string assigment' do
      input = '       three  =    "three_value"    '
      variables = ['three']
      values = ['"three_value"']
      verify_variable_and_value(input, variables, values, false)
    end

    it 'Capture simple variable without spaces and array assigment' do
      input = 'four = []'
      variables = ['four']
      values = ['[]']
      verify_variable_and_value(input, variables, values, false)
    end

    it 'Capture simple variable with spaces and array assigment' do
      input = ' four   =   []    '
      variables = ['four']
      values = ['[]']
      verify_variable_and_value(input, variables, values, false)
    end

    it 'Capture simple variable with spaces and array assigment' do
      input = 'four = [1,2,3,4,5,6]'
      variables = ['four']
      values = ['[1,2,3,4,5,6]']
      verify_variable_and_value(input, variables, values, false)
    end

    it 'Capture simple variable with one @ and string assigment' do
      input = '@four = "four_value"'
      variables = ['four']
      values = ['"four_value"']
      verify_variable_and_value(input, variables, values, false)
    end

    it 'Capture simple variable with @' do
      input = '@four'
      variables = ['four']
      values = ['nothing']
      verify_variable_and_value(input, variables, values, false)
    end

    it 'Capture simple variable with @ and number assigment' do
      input = '@four = 5'
      variables = ['four']
      values = ['5']
      verify_variable_and_value(input, variables, values, false)
    end

    it 'Capture simple variable with two @@' do
      input = '@@four = 5'
      variables = ['four']
      values = ['5']
      verify_variable_and_value(input, variables, values, false)
    end
  end

  context 'Global variable with many different types of assignment' do

    include Helpers

    it 'Variable global with $, array assignment of integers' do
      input = '$y = [1,2,3,4,5,6,7]'
      variables = ['y']
      values = ['[1,2,3,4,5,6,7]']
      verify_variable_and_value(input, variables, values, false)
    end

    it 'Variable global with $, array assignment of strings' do
      input = '$you = ["abc", "zxy", "you"]'
      variables = ['you']
      values = ['["abc","zxy","you"]']
      verify_variable_and_value(input, variables, values, false)
    end

    it 'Variable global with array assignment, with spaces' do
      input = ' $y   =   [1,2,  3,4,5,6, 7 ] '
      variables = ['y']
      values = ['[1,2,3,4,5,6,7 ]']
      verify_variable_and_value(input, variables, values, false)
    end

    it 'Variable global with @@ and empty hash assignment' do
      input = '@@one = {}'
      variables = ['one']
      values = ['{}']
      verify_variable_and_value(input, variables, values, false)
    end

    it 'Variable global with $ and hash values' do
      input = '$twoo = {"x" => 3, "yk" => 7}'
      variables = ['twoo']
      values = '{"x"=>3,"yk"=>7}'
      verify_variable_and_value(input, variables, values, false)
    end

    it 'Variable global with $ and object method called' do
      input = '$joe = Xpto.new'
      variables = ['joe']
      values = 'Xpto.new'
      verify_variable_and_value(input, variables, values, false)
    end

    it 'Variable global with $, object method called, and spaces' do
      input = '$joe    =  Xpto.new  '
      variables = ['joe']
      values = 'Xpto.new'
      verify_variable_and_value(input, variables, values, false)
    end

    it 'Variable global with $, object method with params as a value, and spaces' do
      input = '$mee = abc.mymethod(x, y, 3, "two")'
      variables = ['mee']
      values = 'abc.mymethod(x, y, 3, "two")'
      verify_variable_and_value(input, variables, values, false)
    end
  end

  context 'Special case' do

    it 'Ruby multiple line comment - =begin' do
      variable = @variableRuby.get_variable('=begin')
      expect(variable).to eq(nil)
    end

    it 'Conditional with == comparison' do
      variable = @variableRuby.get_variable(' if xpto == "32"')
      expect(variable).to eq(nil)
    end

    it 'Conditional with += comparison' do
      variable = @variableRuby.get_variable(' if xpto += "32"')
      expect(variable).to eq(nil)
    end

  end

  context 'Complex variable declaration (more then one per line).' do

    include Helpers

    it 'Multiple variable in line WITH = and WITHOUT @' do
      input = 'one = 1, two = 2, three = "three"'
      variables = ['one', 'two', 'three']
      values = ['1', '2', '"three"']
      verify_variable_and_value(input, variables, values, false)
    end

    it 'Multiple variable in line WITH =, WITHOUT @, and with spaces' do
      input = '   one = 1, two     = 2   ,    three    =    "three"    '
      variables = ['one', 'two', 'three']
      values = ['1', '2', '"three"']
      verify_variable_and_value(input, variables, values, false)
    end

    it 'Multiple variable separated by comma and with @' do
      input = '@one, @two, @three'
      variables = ['one', 'two', 'three']
      values = ['nothing', 'nothing', 'nothing']
      verify_variable_and_value(input, variables, values, false)
    end

    it 'Multiple variable separated by comma, with @, and with spaces' do
      input = '   @one            ,      @two,        @three       '
      variables = ['one', 'two', 'three']
      values = ['nothing', 'nothing', 'nothing']
      verify_variable_and_value(input, variables, values, false)
    end

    it 'Multiple variable declaration with =' do
      input = 'one = two = three = 47'
      variables = ['one', 'two', 'three']
      values = ['47', '47', '47']
      verify_variable_and_value(input, variables, values, false)
    end

    it 'Multiple variable declaration with =, and spaces' do
      input = '   one = two      = three      =      47     '
      variables = ['one', 'two', 'three']
      values = ['47', '47', '47']
      verify_variable_and_value(input, variables, values, false)
    end

    it 'Multiple variable declaration with =, and spaces (strings)' do
      input = '   one = two      = three      =      "lala"     '
      variables = ['one', 'two', 'three']
      values = ['"lala"', '"lala"', '"lala"']
      verify_variable_and_value(input, variables, values, false)
    end

  end

  after :all do
    @variableRuby = nil
  end

end
