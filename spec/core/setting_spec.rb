require_relative '../spec_helper'

RSpec.describe Kuniri::Setting do

  def write_kuniri_file(parameter)
    File.open(".kuniri", 'w') do |file|
      file.write("language" + parameter[0] + "\n")
      file.write("source" + parameter[1] + "\n")
      file.write("output" + parameter[2] + "\n")
      file.write("extract" + parameter[3] + "\n")
      file.write("log" + parameter[4] + "\n")
    end
  end

  before :all do
    File.open(".kuniri", 'w') do |file|
      file.write("language:ruby" + "\n")
      file.write("source:xpto" + "\n")
      file.write("output:xpto/2" + "\n")
      file.write("extract:uml,traceability" + "\n")
      file.write("log:html\n")
    end
    @settings = Kuniri::Setting.create 
  end

  context "#read_configuration_file" do
    it "Wrong path, get default configuration" do
    hash_config = @settings.read_configuration_file("wrong/path")
    expect(hash_config).to include(
            "language" => "ruby", 
            "source" => "./", 
            "output" => "./", 
            "extract" => "uml",
            "log" => "html")
    end

    it "Syntax error: not use ':'" do
      write_kuniri_file(["=ruby", ":../app/", ":./", ">uml", ":html"])
      expect{@settings.read_configuration_file(".kuniri")}.to raise_error(
        Error::ConfigurationFileError)
    end

    it "Syntax error: not valid language" do
      write_kuniri_file([":k", ":../app/", ":./", ":uml", ":html"])
      expect{@settings.read_configuration_file(".kuniri")}.to raise_error(
        Error::ConfigurationFileError)
    end

    it "Syntax error: wrong source directory" do
      write_kuniri_file([":ruby", ":xpto/", ":./", ":uml", ":html"])
      expect{@settings.read_configuration_file(".kuniri")}.to raise_error(
        Error::ConfigurationFileError)
    end

    it "Syntax error: wrong output directory" do
      write_kuniri_file([":ruby", ":../app/", ":xpto/", ":uml", ":html"])
      expect{@settings.read_configuration_file(".kuniri")}.to raise_error(
        Error::ConfigurationFileError)
    end

    it "Syntax error: wrong extract" do
      write_kuniri_file([":ruby", ":../app/", ":./", ":umg", ":html"])
      expect{@settings.read_configuration_file(".kuniri")}.to raise_error(
          Error::ConfigurationFileError)
    end

    it "Correct return" do
      write_kuniri_file([":ruby", ":./", ":./", ":uml", ":html"])
      hash_config = @settings.read_configuration_file(".kuniri")
      expect(hash_config).to include(
            "language" => "ruby", 
            "source" => "./", 
            "output" => "./", 
            "extract" => "uml")
    end

    it "Correct return: Case sensitive language" do
      write_kuniri_file([":ruBy", ":lib/", ":./", ":uMl, traCeaBilitY", ":html"])
      expect(@settings.read_configuration_file(".kuniri")).to include(
            "language" => "ruby",
            "source" => "lib/", 
            "output" => "./", 
            "extract" => "uml,traceability")
    end
  end

  after :all do
    File.delete(".kuniri")
  end
end
