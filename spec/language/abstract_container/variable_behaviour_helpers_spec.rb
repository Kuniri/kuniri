require_relative '../../spec_helper'

RSpec.describe Languages::VariableBehaviourHelpers do

  context 'Normal flow' do
    module DummyModule
      class ParentDummy; end
      class DummyClass < ParentDummy; end
    end

    before :each do
      @dummy_class = DummyModule::DummyClass.new
      @dummy_class.extend(Languages::VariableBehaviourHelpers)
    end

    it 'Verify correct behaviour inside who_am_i' do
      expect(@dummy_class.who_am_i).to eq('ParentDummy')
    end

  end

  context 'Testing using Attribute context (real)' do
    before :each do
      @test = Languages::Ruby::AttributeRuby.new
    end

    it 'Get expected object' do
      reference = @test.setup_variable_behaviour
      expect(reference).to be_a_kind_of(Languages::Ruby::VariableBehaviourRuby)
    end

    it 'Verify class name' do
      me = @test.who_am_i
      expect(me).to eq('Attribute')
    end

    it 'Check type of language' do
      my_type = @test.type_of_language
      expect(my_type).to eq('Ruby')
    end

    after :each do
      @test = nil
    end
  end

end
