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
  end
end
