require_relative '../spec_helper'

RSpec.describe Kuniri::Setting do

  def write_kuniri_file(parameter)
    File.open(".kuniri-test.yml", 'w') do |file|
      file.write(":language: " + parameter[0] + "\n")
      file.write(":source: " + parameter[1] + "\n")
      file.write(":output: " + parameter[2] + "\n")
    end
  end

  before :each do
    File.open(".kuniri-test.yml", 'w') do |file|
      file.write(":language: ruby" + "\n")
      file.write(":source: xpto" + "\n")
      file.write(":output: xpto/2" + "\n")
    end
    @settings = Kuniri::Setting.create
  end

  context "When setting is created." do
    it "Only one reference of Setting." do
      @settingsTwo = Kuniri::Setting.create
      expect((@settingsTwo == @settings)).to be true
    end
  end

  context "When configuration file is wrong." do
    it "Wrong path, get default configuration" do
      defaultConf = @settings.read_configuration_file("wrong/path")
      expect(defaultConf).to include(
            :language => "ruby",
            :source => "./",
            :output => "./")
    end

    it "Syntax error: not valid language." do
      write_kuniri_file(["k", "../app/", "./"])
      expect{@settings.read_configuration_file(".kuniri-test.yml")}.to raise_error(
        Error::ConfigurationFileError)
    end

    it "Syntax error: wrong source directory." do
      write_kuniri_file(["ruby", "xpto/", "./"])
      expect{@settings.read_configuration_file(".kuniri-test.yml")}.to raise_error(
        Error::ConfigurationFileError)
    end

    it "Syntax error: wrong output directory." do
      write_kuniri_file(["ruby", "../app/", "xpto/"])
      expect{@settings.read_configuration_file(".kuniri-test.yml")}.to raise_error(
        Error::ConfigurationFileError)
    end

  end

  context "When input is correct." do
    it "Correct return." do
      write_kuniri_file(["ruby", "./", "./"])
      hash_config = @settings.read_configuration_file(".kuniri-test.yml")
      expect(hash_config).to include(
            :language => "ruby",
            :source => "./",
            :output => "./")
    end

    it "Correct return, different parameters." do
      write_kuniri_file(["ruby", "./", "./"])
      hash_config = @settings.read_configuration_file(".kuniri-test.yml")
      expect(hash_config).to include(
            :language => "ruby",
            :source => "./",
            :output => "./")
    end


    it "Not right: Case sensitive language." do
      write_kuniri_file(["ruBy", "lib/", "./"])
      expect{@settings.read_configuration_file(".kuniri-test.yml")}.to raise_error(
         Error::ConfigurationFileError)
    end
  end

  after :each do
    File.delete(".kuniri-test.yml")
  end
end
