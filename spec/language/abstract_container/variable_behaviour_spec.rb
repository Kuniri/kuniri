require_relative '../../spec_helper'

RSpec.describe Languages::VariableBehaviour do

  let(:variable_object) {Languages::VariableBehaviour.new}

  context 'Simple case of Not implemented method' do

    before(:all) do
      Languages::VariableBehaviour.send(:public, *Languages::VariableBehaviour.protected_instance_methods)
    end

    it 'Expect to raise error to call common_declaration' do
      expect{variable_object.common_declaration('xpto')}
            .to raise_error(NotImplementedError)
    end

    it 'Expect to raise error to call pre_process' do
      expect{variable_object.pre_process('xpto')}
            .to raise_error(NotImplementedError)
    end

    it 'Expect to raise error to call replace_strings_and_params' do
      expect{variable_object.replace_strings_and_params('xpto')}
            .to raise_error(NotImplementedError)
    end

    it 'Expect to raise error to call replace_strings_and_params' do
      expect{variable_object.replace_commas_inside_brackets_and_braces('xpto')}
            .to raise_error(NotImplementedError)
    end

    it 'Expect to raise error to call replace_equals' do
      expect{variable_object.replace_equals('xpto')}
            .to raise_error(NotImplementedError)
    end

    it 'Expect to raise error to break_string_line' do
      expect{variable_object.break_string_line('xpto')}
            .to raise_error(NotImplementedError)
    end

    it 'Expect to raise error to build_hash_of_variables_and_values' do
      expect{variable_object.build_hash_of_variables_and_values([],{})}
            .to raise_error(NotImplementedError)
    end

    it 'Expect to raise error to is_variable?' do
      expect{variable_object.is_variable?('xpto')}
            .to raise_error(NotImplementedError)
    end

    it 'Expect to raise error to process_value' do
      expect{variable_object.process_value([],{})}
            .to raise_error(NotImplementedError)
    end

    it 'Expect to raise error to process_value' do
      expect{variable_object.normalize_elements('xpto')}
            .to raise_error(NotImplementedError)
    end

  end

end
