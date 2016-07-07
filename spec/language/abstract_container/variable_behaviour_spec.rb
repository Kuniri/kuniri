require_relative '../../spec_helper'

RSpec.describe Languages::VariableBehaviour do

  let(:variable_object) {Languages::VariableBehaviour.new}
  let(:one_var) {'xpto = 5'}
  let(:regex_one_var) {/xpto = 5/}
  let(:var_with_equal) {'xpto = lalala = 5'}
  let(:regex_with_equal) {/xpto = lalala = 5/}
  let(:var_with_comma) {'xpto, lalala = 5'}
  let(:regex_with_comma) {/xpto, lalala = 5/}

  context 'Call common declaration' do
    it 'Expect to raise error' do
      expect{variable_object.common_declaration(one_var, regex_one_var)}
            .to raise_error(NotImplementedError)
    end

    it 'Cannot pass through the first step' do
      result = variable_object.common_declaration('xpto = 5', /xpto = 7/)
      expect(result).to eq(nil)
    end
  end

  context 'Raise error after remove_unnecessary_information' do
    before :each do
      @variable = Languages::VariableBehaviour.new
      allow(@variable).to receive(:remove_unnecessary_information)
                                  .and_return(one_var)
    end

    it 'Should raise error because handle_line_declaration' do
      expect{@variable.common_declaration(one_var, regex_one_var)}
            .to raise_error(NotImplementedError)
    end
  end

  context 'Raise error after remove_unnecessary_information in "=" branch' do
    before :each do
      @variable = Languages::VariableBehaviour.new
      allow(@variable).to receive(:remove_unnecessary_information)
                                  .and_return(var_with_equal)
    end

    it 'Raise error because handle_multiple_declaration_with_equal' do
      expect{@variable.common_declaration(var_with_equal, regex_with_equal)}
            .to raise_error(NotImplementedError)
    end
  end

  context 'Raise error after remove_unnecessary_information in "," branch' do
    before :each do
      @variable = Languages::VariableBehaviour.new
      allow(@variable).to receive(:remove_unnecessary_information)
                                  .and_return(var_with_comma)
    end

    it 'Raise error because handle_multiple_declaration_with_equal' do
      expect{@variable.common_declaration(var_with_comma, regex_with_comma)}
            .to raise_error(NotImplementedError)
    end
  end

  context 'Apply normalization' do
    before :each do
      @variable = Languages::VariableBehaviour.new
    end

    it 'Call normalize, and do nothing' do
      not_normalize = ['la', 'lala', 'lalala', 'lalalala']
      array_to_send = []
      not_normalize.each do |element|
        array_to_send.push(Languages::AttributeData.new(element))
      end
      normalized = @variable.send(:normalize_elements, array_to_send)
      expect(normalized).to match_array(array_to_send)
    end

    it 'Call normalize, and remove number' do
      normalize = ['la', 'lala', 'lalala', 'lalalala', '89']
      array_to_send = []
      normalize.each do |element|
        array_to_send.push(Languages::AttributeData.new(element))
      end
      normalized = @variable.send(:normalize_elements, array_to_send.dup)
      expect(normalized).to_not match_array(array_to_send)
    end

    it 'String number, should be recognized' do
      expect(@variable.send(:is_number?, '1')).to eq(true)
      expect(@variable.send(:is_number?, '0')).to eq(true)
      expect(@variable.send(:is_number?, '01')).to eq(true)
      expect(@variable.send(:is_number?, '-1')).to eq(true)
      expect(@variable.send(:is_number?, '987987123')).to eq(true)
    end

    it 'String name, should be recognized' do
      expect(@variable.send(:is_number?, 'a')).to eq(false)
      expect(@variable.send(:is_number?, 'ab0')).to eq(false)
      expect(@variable.send(:is_number?, 'lala1a')).to eq(false)
      expect(@variable.send(:is_number?, 'jalkjslifjlskfjaoi')).to eq(false)
    end

  end
end
