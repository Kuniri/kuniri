require_relative '../spec_helper'

RSpec.describe Languages::LanguageFactory do

  before :all do
    @factory = Languages::LanguageFactory.new
  end

  context "When have supprt to language." do
    it "Ruby support." do
      expect(@factory.get_language("ruby").is_a?(Languages::RubySyntax))
              .to be true
    end
    it "C++ support." do
      expect(@factory.get_language("cplusplus").is_a?(Languages::CplusplusSyntax))
              .to be true
    end
  end

  context "When have not support." do
    it "Python support." do
      expect{@factory.get_language("python")}.to raise_error(
            Error::LanguageError)
    end

    it "vhdl support." do
      expect{@factory.get_language("vhdl")}.to raise_error(
            Error::LanguageError)
    end

    it "C support." do
      expect{@factory.get_language("c")}.to raise_error(
            Error::LanguageError)
    end

    it "Java support." do
      expect{@factory.get_language("java")}.to raise_error(
            Error::LanguageError)
    end

    it "Assembly arm support." do
      expect{@factory.get_language("assemblyarm")}.to raise_error(
            Error::LanguageError)
    end

    it "PHP support." do
      expect{@factory.get_language("php")}.to raise_error(
            Error::LanguageError)
    end

    it "Nothing." do
      expect{@factory.get_language("")}.to raise_error(
            Error::LanguageError)
    end


  end

  after :all do
    @factory = nil
  end

end
