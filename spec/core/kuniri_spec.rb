require_relative '../spec_helper'

RSpec.describe Kuniri::Kuniri do

  context "When path for run_analysis is wrong." do
    it "Wrong path to " do
      @kuniriTest = Kuniri::Kuniri.new("wrong/path")
      defaultPath = @kuniriTest.run_analysis
      folderFiles = Dir[File.join("./", "**", "**.rb")]
      expect(defaultPath).to match_array(folderFiles)
    end
  end

end
