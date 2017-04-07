require_relative '../spec_helper'
require 'fileutils'
RSpec.describe Kuniri::Kuniri do

  context "When path for run_analysis is wrong." do
    it "Wrong path to " do
      @kuniriTest = Kuniri::Kuniri.new
      @kuniriTest.read_configuration_file('./wrong/path')
      defaultPath = @kuniriTest.run_analysis
      folderFiles = Dir[File.join("./", "**", "**.rb")]
      expect(defaultPath).to match_array(folderFiles)
    end

  end

  context "When source directory is empty" do
    before :each do
      if Dir.exists?('empty_directory')
        FileUtils.rm_rf('empty_directory')
      end      
      FileUtils.mkdir('empty_directory')
    end

    it "Should not crash" do

      @kuniriTest = Kuniri::Kuniri.new
      @kuniriTest.set_configuration('./empty_directory/', 'ruby', 'output_dir', 0)

      begin
        expect {@kuniriTest.run_analysis}.not_to raise_error
      rescue => e
        expect(e).not_to be_a(Error::ConfigurationFileError)
      end

    end
    after :each do
      if Dir.exists?('output_dir')
        FileUtils.rm_rf('output_dir')
      end
      FileUtils.rm_rf('empty_directory')
    end
  end
end
