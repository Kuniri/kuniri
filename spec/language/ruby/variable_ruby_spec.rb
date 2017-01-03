require_relative '../../spec_helper'

RSpec.describe Languages::Ruby::VariableGlobalRuby do

  before :all do
    @variableRuby = Languages::Ruby::VariableGlobalRuby.new
  end

  context 'Simple variable (one per line)' do

    it 'Capture simple variable.' do
      variable = @variableRuby.get_variable('one = 1')
      expect(variable[0].name).to eq('one')
      expect(variable[0].value).to eq('1')

      variable = @variableRuby.get_variable('  two = 2')
      expect(variable[0].name).to eq('two')
      expect(variable[0].value).to eq('2')

      variable = @variableRuby.get_variable('three = "three_value"')
      expect(variable[0].name).to eq('three')
      expect(variable[0].value).to eq('"three_value"')

      variable = @variableRuby.get_variable('four = []')
      expect(variable[0].name).to eq('four')
      expect(variable[0].value).to eq('[]')
    end

    it 'Capture simple variable with one @' do
      variable = @variableRuby.get_variable('@one')
      expect(variable[0].name).to eq('one')

      variable = @variableRuby.get_variable('@four = "four_value"')
      expect(variable[0].name).to eq('four')
      expect(variable[0].value).to eq('"four_value"')

      variable = @variableRuby.get_variable('   @five = 5')
      expect(variable[0].name).to eq('five')
      expect(variable[0].value).to eq('5')
    end

    it 'Capture simple variable with two @@' do
      variable = @variableRuby.get_variable('@@three')
      expect(variable[0].name).to eq('three')
    end

  end

  context 'Verify value assignment to simple global variable.' do
    it 'Simple case: without @, @@ or $' do
      variable = @variableRuby.get_variable('yesImVerySimpe = 12')
      expect(variable[0].value).to eq('12')

      variable = @variableRuby.get_variable('     yesImVerySimpe = 12')
      expect(variable[0].value).to eq('12')

      variable = @variableRuby.get_variable('   yesImVerySimpe = 12   ')
      expect(variable[0].value).to eq('12')

      variable = @variableRuby.get_variable('yesImVerySimpe   = 12')
      expect(variable[0].value).to eq('12')

      variable = @variableRuby.get_variable('yesImVerySimpe   =   12')
      expect(variable[0].value).to eq('12')

      variable = @variableRuby.get_variable('   yesImVerySimpe   =   12   ')
      expect(variable[0].value).to eq('12')

      variable = @variableRuby.get_variable('   yesImVerySimpe   =   "yes"   ')
      expect(variable[0].value).to eq('"yes"')
    end

    it 'Value after variable with @' do
      variable = @variableRuby.get_variable('@yesImVerySimpe = 12')
      expect(variable[0].value).to eq('12')

      variable = @variableRuby.get_variable('     @yesImVerySimpe = 12')
      expect(variable[0].value).to eq('12')

      variable = @variableRuby.get_variable('   @yesImVerySimpe = 12   ')
      expect(variable[0].value).to eq('12')

      variable = @variableRuby.get_variable('@yesImVerySimpe   = 12')
      expect(variable[0].value).to eq('12')

      variable = @variableRuby.get_variable('@yesImVerySimpe   =   12')
      expect(variable[0].value).to eq('12')

      variable = @variableRuby.get_variable('   @yesImVerySimpe   =   12   ')
      expect(variable[0].value).to eq('12')

      variable = @variableRuby.get_variable(' @yesImVerySimpe  =   "yes"   ')
      expect(variable[0].value).to eq('"yes"')
    end

    it 'Value after variable with @@' do
      variable = @variableRuby.get_variable('@@yesImVerySimpe = 12')
      expect(variable[0].value).to eq('12')

      variable = @variableRuby.get_variable('     @@yesImVerySimpe = 12')
      expect(variable[0].value).to eq('12')

      variable = @variableRuby.get_variable('   @@yesImVerySimpe = 12   ')
      expect(variable[0].value).to eq('12')

      variable = @variableRuby.get_variable('@@yesImVerySimpe   = 12')
      expect(variable[0].value).to eq('12')

      variable = @variableRuby.get_variable('@@yesImVerySimpe   =   12')
      expect(variable[0].value).to eq('12')

      variable = @variableRuby.get_variable('   @@yesImVerySimpe   =   12   ')
      expect(variable[0].value).to eq('12')

      variable = @variableRuby.get_variable('  @@yesImVerySimpe   =  "yes" ')
      expect(variable[0].value).to eq('"yes"')
    end

    it 'Value after variable with $' do
      variable = @variableRuby.get_variable('$yesImVerySimpe = 12')
      expect(variable[0].value).to eq('12')

      variable = @variableRuby.get_variable('     $yesImVerySimpe = 12')
      expect(variable[0].value).to eq('12')

      variable = @variableRuby.get_variable('   $yesImVerySimpe = 12   ')
      expect(variable[0].value).to eq('12')

      variable = @variableRuby.get_variable('$yesImVerySimpe   = 12')
      expect(variable[0].value).to eq('12')

      variable = @variableRuby.get_variable('$yesImVerySimpe   =   12')
      expect(variable[0].value).to eq('12')

      variable = @variableRuby.get_variable('   $yesImVerySimpe   =   12   ')
      expect(variable[0].value).to eq('12')

      variable = @variableRuby.get_variable(' $yesImVerySimpe   =  "yes" ')
      expect(variable[0].value).to eq('"yes"')
    end
  end

  context 'Global variable with many different types of assignment' do
    it 'Variable global with array assignment' do
      variable = @variableRuby.get_variable('$y = [1,2,3,4,5,6,7]')
      expect(variable[0].name).to eq('y')
      expect(variable[0].value).to eq('[1,2,3,4,5,6,7]')

      variable = @variableRuby.get_variable('$you = ["abc", "zxy", "you"]')
      expect(variable[0].name).to eq('you')
      expect(variable[0].value).to match(/\s*[\s*"abc"\s*,\s*"zxy",\s*"you"\s*]\s*/)
    end

    it 'Variable global with array assignment, with spaces' do
      variable = @variableRuby.get_variable(' $y   =   [1,2,  3,4,5,6, 7 ] ')
      expect(variable[0].name).to eq('y')
      expect(variable[0].value).to match(/\s*[\s*1\s*,\s*2\s*,\s*3\s*,\s*4\s*,\s*5\s*,\s*6\s*,\s*7\s*]\s*/)

      variable = @variableRuby.get_variable('$you=   [ "abc", "zxy", "you"]')
      expect(variable[0].name).to eq('you')
      expect(variable[0].value).to match(/\s*[\s*"abc"\s*,\s*"zxy",\s*"you"\s*]\s*/)
    end

    it 'Variable global with array assignment, without spaces' do
      variable = @variableRuby.get_variable('$y=[1,2,3,4,5,6,7]')
      expect(variable[0].name).to eq('y')
      expect(variable[0].value).to eq('[1,2,3,4,5,6,7]')

      variable = @variableRuby.get_variable('$you=["abc","zxy","you"]')
      expect(variable[0].name).to eq('you')
      expect(variable[0].value).to eq('["abc","zxy","you"]')
    end

    it 'Variable global with hash assignment' do
      variable = @variableRuby.get_variable('@@one = {}')
      expect(variable[0].name).to eq('one')
      expect(variable[0].value).to eq('{}')

      variable = @variableRuby.get_variable('$twoo = {"x" => 3, "yk" => 7}')
      expect(variable[0].name).to eq('twoo')
      expect(variable[0].value).to match(/\s*\{\s*"x"\s*=>\s*3\s*,\s*"yk"\s*=>\s*7\s*\}\s*/)

      variable = @variableRuby.get_variable('@@one={}')
      expect(variable[0].name).to eq('one')
      expect(variable[0].value).to eq('{}')
    end

    it 'Variable global with hash assignment and spaces' do
      variable = @variableRuby.get_variable('     @@one   =   {}  ')
      expect(variable[0].name).to eq('one')
      expect(variable[0].value).to eq('{}')

      variable = @variableRuby.get_variable(' $twoo  = {"x" => 3,    "yk" => 7 } ')
      expect(variable[0].name).to eq('twoo')
      expect(variable[0].value).to match(/\s*\{\s*"x"\s*=>\s*3\s*,\s*"yk"\s*=>\s*7\s*\}\s*/)
    end

    it 'Variable global with object' do
      variable = @variableRuby.get_variable('$joe = Xpto.new')
      expect(variable[0].name).to eq('joe')
      expect(variable[0].value).to eq('Xpto.new')
    end

    it 'Variable global with object and spaces' do
      variable = @variableRuby.get_variable('$joe    =  Xpto.new  ')
      expect(variable[0].name).to eq('joe')
      expect(variable[0].value).to eq('Xpto.new')
    end

    it 'Variable global with method call' do
      variable = @variableRuby.get_variable('$mee = abc.mymethod')
      expect(variable[0].name).to eq('mee')
      expect(variable[0].value).to eq('abc.mymethod')
    end

    it 'Variable global with method call and parameters' do
      variable = @variableRuby.get_variable('$mee = abc.mymethod (1, "tres")')
      expect(variable[0].name).to eq('mee')
      expect(variable[0].value).to match(/\s*abc.mymethod\s*\(\s*1\s*,\s*"tres"\s*\)\s*/)
    end

    it 'Variable global with method call, with parameters and no spaces' do
      variable = @variableRuby.get_variable('$mee=abc.mymethod(1,"tres")')
      expect(variable[0].name).to eq('mee')
      expect(variable[0].value).to eq('abc.mymethod(1,"tres")')
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

  RSpec.shared_examples 'Compare array' do |lineInput, arrayComp, description|

    it ": #{description}" do
      listResult = []
      capturedList = @variableRuby.get_variable(lineInput)
      capturedList.each do |element|
        listResult.push(element.name)
      end
      expect(listResult).to match_array(arrayComp)
    end
  end

  context 'Complex variable declaration (more then one per line).' do
    lineParse = 'one = 1, two = 2, three = "three"'
    arrayCompare = ['one', 'two', 'three']
    message = ' -> Multiple variable in line WITH = and WITHOUT @.'
    include_examples 'Compare array', lineParse, arrayCompare, message

    lineParse = '     one   =  1,   two=2, three    =     "three"   '
    arrayCompare = ['one', 'two', 'three']
    message = ' -> Multiple variable in line WITH = and WITHOUT @. (Not nice)'
    include_examples 'Compare array', lineParse, arrayCompare, message

    lineParse = '@one, @two, @three'
    arrayCompare = ['one', 'two', 'three']
    message = ' -> Multiple variable in line ONLY WITH , and @.'
    include_examples 'Compare array', lineParse, arrayCompare, message

    lineParse = '       @one    , @two     ,       @three  '
    arrayCompare = ['one', 'two', 'three']
    message = ' -> Multiple variable in line ONLY WITH , and @. (Not nice)'
    include_examples 'Compare array', lineParse, arrayCompare, message

    lineParse = '@one = 1, @two = 2, @three = "three"'
    arrayCompare = ['one', 'two', 'three']
    message = ' -> Multiple variable in line WITH = and @.'
    include_examples 'Compare array', lineParse, arrayCompare, message

    lineParse = '     @one = 1, @two =2     ,@three   =   "three"'
    arrayCompare = ['one', 'two', 'three']
    message = ' -> Multiple variable in line WITH = and @. (Not nice)'
    include_examples 'Compare array', lineParse, arrayCompare, message

    lineParse = ' @one, @two = 3,@three '
    arrayCompare = ['one', 'two', 'three']
    message = ' -> Multiple variable in line WITH = and @. (Mixed)'
    include_examples 'Compare array', lineParse, arrayCompare, message

    #it 'Multiple declaration with assignment, simple case.' do
    lineParse = 'one = two = three = 47'
    arrayCompare = ['one', 'two', 'three']
    message = ' -> Multiple variable ONLY WITH ='
    include_examples 'Compare array', lineParse, arrayCompare, message

    lineParse = 'one                  =two     =    three =   47'
    arrayCompare = ['one', 'two', 'three']
    message = ' -> Multiple variable ONLY WITH =. (Not nice)'
    include_examples 'Compare array', lineParse, arrayCompare, message
    #end

    lineParse = '@one = @two = @three = 59'
    arrayCompare = ['one', 'two', 'three']
    message = ' -> Multiple variable WITH = and @'
    include_examples 'Compare array', lineParse, arrayCompare, message

    lineParse = '     @one                =   @two =  @three =   89 '
    arrayCompare = ['one', 'two', 'three']
    message = ' -> Multiple variable WITH = and @. (Not nice)'
    include_examples 'Compare array', lineParse, arrayCompare, message

  end

  after :all do
    @variableRuby = nil
  end

end
