require_relative '../../spec_helper'

RSpec.describe Languages::VariableBehaviour do

  let(:variable_object) {Languages::VariableBehaviour.new}
  let(:one_var) {'xpto = 5'}
  let(:regex_one_var) {/xpto = 5/}

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

end
