require_relative '../../spec_helper'

RSpec.describe Languages::Ruby::ClassRuby do

  before :all do 
    @classRuby = Languages::Ruby::ClassRuby.new
  end

  context "# Class handling" do

    it "Ordinary class declaration" do
      classNameCaptured = @classRuby.get_class("class Xpto").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classRuby.get_class("     class      Xpto").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classRuby.get_class("     class      Xpto   ").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classRuby.get_class("        class Xpto").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classRuby.get_class("class Xpto        ").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classRuby.get_class("  class  Xpto      ").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classRuby.get_class(" class Xpto  ").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classRuby.get_class(" class Xpto").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classRuby.get_class("class  Xpto  ").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classRuby.get_class(" class  Xpto ").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classRuby.get_class("    class  Xpto  ").name
      expect(classNameCaptured).to eq("Xpto")

    end

    it "Class with inheritance" do
      classNameCaptured = @classRuby.get_class("class Xpto < Abc").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classRuby.get_class("     class   Xpto < Abc").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classRuby.get_class("class Xpto   < Abc").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classRuby.get_class("   class   Xpto < Abc ").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classRuby.get_class("class Xpto      <    Abc").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classRuby.get_class("  class   Xpto < Abc   ").name
      expect(classNameCaptured).to eq("Xpto")
    end

  end

  after :all do
    @classRuby = nil
  end

end
