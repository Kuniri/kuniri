require_relative '../../spec_helper'

RSpec.describe Languages::Ruby::VariableBehaviourRuby do

  before :all do
    @varRuby = Languages::Ruby::VariableBehaviourRuby.new('VariableGlobal')
    @attrRuby = Languages::Ruby::VariableBehaviourRuby.new('Attribute')
  end

  context 'Basic behaviour of commom_declaration' do

    describe 'Simple variables without spaces' do

      it 'Capture simple variable with integer assigment' do
        var = @varRuby.common_declaration('one = 1')
        expect(var['one']).to eq('1')
      end

      it 'Capture simple variable with string assigment' do
        var = @varRuby.common_declaration('one = "la"')
        expect(var['one']).to eq('"la"')
      end

      it 'Capture simple variable with empty string assigment' do
        var = @varRuby.common_declaration('one = ""')
        expect(var['one']).to eq('""')
      end

      it 'Capture simple variable with empty array assigment' do
        var = @varRuby.common_declaration('one = []')
        expect(var['one']).to eq('[]')
      end

      it 'Capture simple variable with array assigment' do
        var = @varRuby.common_declaration('one = [1,2,3]')
        expect(var['one']).to eq('[1,2,3]')
      end

      it 'Capture simple variable with empty hash assigment' do
        var = @varRuby.common_declaration('one = {}')
        expect(var['one']).to eq('{}')
      end

      it 'Capture simple variable with hash assigment' do
        var = @varRuby.common_declaration('one = {"one"=>1,"two"=>2,"t"=>3}')
        expect(var['one']).to eq('{"one"=>1,"two"=>2,"t"=>3}' )
      end

      it 'Capture simple variable with @' do
        attr = @attrRuby.common_declaration('@off')
        expect(attr['@off']).to eq('nothing')
      end

      it 'Capture simple variable with @@' do
        attr = @attrRuby.common_declaration('@@off')
        expect(attr['@@off']).to eq('nothing')
      end

      it 'Capture simple variable with $' do
        attr = @attrRuby.common_declaration('$off')
        expect(attr['$off']).to eq('nothing')
      end

    end

    describe 'Simple variables with spaces' do

      it 'Capture simple variable' do
        var = @varRuby.common_declaration('     one     =     1 ')
        expect(var['one']).to eq('1')
      end

      it 'Capture simple variable with @' do
        attr = @attrRuby.common_declaration('   @off   ')
        expect(attr['@off']).to eq('nothing')
      end

      it 'Capture simple variable with @@' do
        attr = @attrRuby.common_declaration('     @@off ')
        expect(attr['@@off']).to eq('nothing')
      end

      it 'Capture simple variable with $' do
        attr = @attrRuby.common_declaration(' $off       ')
        expect(attr['$off']).to eq('nothing')
      end

    end

    describe 'Multiple declaration with =' do
      it 'Capture simple variable' do
        attr = @attrRuby.common_declaration('one = two = three = 41')
        attr.each do |variable, value|
          expect(attr[variable]).to eq('41')
        end
      end

      it 'Capture simple variable with $' do
        attr = @attrRuby.common_declaration('$one = $two = $three = 41')
        attr.each do |variable, value|
          expect(attr[variable]).to eq('41')
        end
      end

      it 'Capture simple variable with @' do
        attr = @attrRuby.common_declaration('@one = @two = @three = 41')
        attr.each do |variable, value|
          expect(attr[variable]).to eq('41')
        end
      end

      it 'Capture simple variable with @@' do
        attr = @attrRuby.common_declaration('@@one = @@two = @@three = "str"')
        attr.each do |variable, value|
          expect(attr[variable]).to eq('"str"')
        end
      end

    end

    describe 'Multiple declaration with ,' do
      it 'Simple variable' do
        attr = @attrRuby.common_declaration('one, two, three')
        attr.each do |variable, value|
          expect(attr[variable]).to eq('nothing')
        end
      end

      it 'Simple variable with $' do
        attr = @attrRuby.common_declaration('$one, $two, $three')
        attr.each do |variable, value|
          expect(attr[variable]).to eq('nothing')
        end
      end

      it 'Simple variable with @' do
        attr = @attrRuby.common_declaration('@one = 41, @two = 41, @three = 41')
        attr.each do |variable, value|
          expect(attr[variable]).to eq('41')
        end
      end
    end

    describe 'Mixed multiple declaration with , and =' do
      it 'Comma with equals' do
        attr = @attrRuby.common_declaration('one = "no", two = "no", three = "no", four = five = "no"')
        attr.each do |variable, value|
          expect(attr[variable]).to eq('"no"')
        end
      end

      it 'Equals with comma' do
        attr = @attrRuby.common_declaration('four = five = "no", one = "no", two = "no", three = "no"')
        attr.each do |variable, value|
          expect(attr[variable]).to eq('"no"')
        end
      end
    end

  end

  context 'Internals of VariableBehaviourRuby implementation' do

    before(:all) do
      Languages::Ruby::VariableBehaviourRuby.send(:public, *Languages::Ruby::VariableBehaviourRuby.protected_instance_methods)
      @inside = Languages::Ruby::VariableBehaviourRuby.new('VariableGlobal')
    end

    describe 'Replace string and parameters (replace_strings_and_params)' do
      before(:each) do
        @singleValueString = '$value = "text1"'
        @multipleValueString = '$value0 = "text0", $value1 = "text1", @value2 = "text2"'
      end

      it 'Replace strings and parameters inside string' do
        line, hash = @inside.replace_strings_and_params(@singleValueString)
        expect(line).to eq('$value = <str0>')
        expect(hash['str0']).to eq('"text1"')
      end

      it 'Replace multiple strings inside line' do
        line, hash = @inside.replace_strings_and_params(@multipleValueString)
        expect(line).to eq('$value0 = <str0>, $value1 = <str1>, @value2 = <str2>')
        expect(hash['str0']).to eq('"text0"')
        expect(hash['str1']).to eq('"text1"')
        expect(hash['str2']).to eq('"text2"')
      end

      it 'Replace strings inside hash' do
        line, hash = @inside.replace_strings_and_params('$value0 = {"one" => 1, "two" => 2}')
        expect(line).to eq('$value0 = {<str0> => 1, <str1> => 2}')
        expect(hash['str0']).to eq('"one"')
        expect(hash['str1']).to eq('"two"')
      end

      it 'Replace method parameters with parentheses' do
        line, hash = @inside.replace_strings_and_params('$value0 = xpto.method1(3, "yes", true)')
        expect(line).to eq('$value0 = xpto.method1<str0>')
        expect(hash['str0']).to eq('(3, "yes", true)')
      end

     # TODO: This is a important case that should be handled
     # it 'Replace method parameters without parentheses' do
     #   line, hash = @inside.replace_strings_and_params('$value0 = xpto.method1 3, "yes", true')
     #   expect(line).to eq('$value0 = xpto.method1<str0>')
     #   expect(hash['str0']).to eq('(3, "yes", true)')
     # end

      after(:each) do
        @singleValueString = nil
        @multipleValueString = nil
      end
    end

    describe 'Replace commas inside brackets and braces' do

      it 'Replace commas inside array by <comma>' do
         value = @inside.replace_commas_inside_brackets_and_braces('[1,3,4,34234]')
         expect(value).to eq('[1<comma>3<comma>4<comma>34234]')
      end

      it 'Replace commas inside array by <comma> (strings and numbers)' do
         value = @inside.replace_commas_inside_brackets_and_braces('[1,3,"test"]')
         expect(value).to eq('[1<comma>3<comma>"test"]')
      end

      it 'Replace commas inside hash by <comma> and => by <hash>' do
         value = @inside.replace_commas_inside_brackets_and_braces('{"one"=>1, "2"=>"two"}')
         expect(value).to eq('{"one"<hash>1<comma> "2"<hash>"two"}')
      end

      it 'Should not replace any comma' do
         value = @inside.replace_commas_inside_brackets_and_braces('@abc, $defg, @@hi, la')
         expect(value).to eq('@abc, $defg, @@hi, la')
      end

    end

    describe 'Replace equals for assigments' do

      it 'Single assigments' do
        value = @inside.replace_equals('xpto = 300')
        expect(value).to eq('xpto <equal> 300')
      end

      it 'Multiple assigments' do
        value = @inside.replace_equals('xpto = lala=abc=300')
        expect(value).to eq('xpto <equal> lala<equal>abc<equal>300')
      end

      it 'Should not replace double equals' do
        value = @inside.replace_equals('xpto == 300')
        expect(value).to eq(nil)
      end

      it 'Should not replace =>' do
        value = @inside.replace_equals('xpto => 300')
        expect(value).to eq(nil)
      end

      it 'Should not replace <=' do
        value = @inside.replace_equals('xpto <= 300')
        expect(value).to eq(nil)
      end

      it 'Should not replace ===' do
        value = @inside.replace_equals('xpto === 300')
        expect(value).to eq(nil)
      end

    end

    describe 'Build hash of variables and values' do

      it 'Simple case with equal' do
        variableList = ['one <equal> <str0>', 'two <equal> <str1>']
        stringValue = {'str0'=>'"one"', 'str1'=>'"two"'}
        value = @inside.build_hash_of_variables_and_values(variableList, stringValue)
        expect(value['one']).to eq('"one"')
        expect(value['two']).to eq('"two"')
      end

      it 'Case with multiple equals assigments' do
        variableList = ['one <equal> two <equal> three <equal> <str0>']
        stringValue = {'str0'=>'"lala"'}
        value = @inside.build_hash_of_variables_and_values(variableList, stringValue)
        expect(value['one']).to eq('"lala"')
        expect(value['two']).to eq('"lala"')
        expect(value['three']).to eq('"lala"')
      end

      it 'Case without assigment of value' do
        variableList = ['one']
        value = @inside.build_hash_of_variables_and_values(variableList, {})
        expect(value['one']).to eq('nothing')
      end

      it 'Should not parse variable started with .' do
        variable = ['xpto.one']
        stringValue = {'str0'=>'"one"'}
        value = @inside.build_hash_of_variables_and_values(variable, stringValue)
        expect(value).to eq({})
      end

    end

    describe 'Verify if is variable' do
      it 'Variables with . in the rvalue cannot be new' do
        variable = '@xpto.lala = 41'
        value = @inside.is_variable?(variable)
        expect(value).to eq(false)
      end

      it 'Valid variable should be accepted' do
        variable = 'lala = 32'
        expect(@inside.is_variable?(variable)).to eq(true)
      end
    end

    describe 'Process values' do
      it 'Replace string inside values' do
        value = 'one <equal> <str0>'
        stringValue = {'str0' => '"lululu"'}
        value = @inside.process_value(value, stringValue)
        expect(value).to eq('one <equal>"lululu"')
      end

      it 'Nothing to be replaced' do
        value = 'one'
        value = @inside.process_value(value, {})
        expect(value).to eq('one')
      end
    end

    describe 'Normalize elements' do
      it 'Replace <comma>' do
        value = {'arrayV' => '[1<comma>2<comma>3]'}
        value = @inside.normalize_elements(value)
        expect(value['arrayV']).to eq('[1,2,3]')
      end

      it 'Replace <hash> and <comma>' do
        value = {'hashV' => '{"one"<hash>1<comma>"two"<hash>"two"}'}
        value = @inside.normalize_elements(value)
        expect(value['hashV']).to eq('{"one"=>1,"two"=>"two"}')
      end
    end

  end

  context 'Do not detect' do
    it 'Should not detect string with equal in the begining' do
      var = @varRuby.common_declaration('=begin')
      expect(var).to eq({})
    end
  end

  after :all do
    @variableRuby = nil
  end

end
