require_relative '../../spec_helper'

RSpec.describe Languages::Attribute do

  before :all do
    @attribute = Languages::Attribute.new
  end

  context 'Call to get_attribute' do
    it 'Expect to raise error' do
      expect{@attribute.get_attribute('@attribute')}
        .to raise_error(NotImplementedError)
    end
  end

  after :all do
    @attribute = nil
  end

end
