require_relative '../spec_helper'

RSpec.describe Util::Logger do
    
  before :all do
    @abstractLogger = Util::Logger.new
  end

  context "Try to write." do
    it "Try to access implemented error." do
      expect{@abstractLogger.write_log("xpto")}.to raise_error(
              NotImplementedError)
    end
  end 

  after :all do
    @abstractLogger = nil
  end

end
