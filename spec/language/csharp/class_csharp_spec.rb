require_relative '../../spec_helper'

RSpec.describe Languages::Csharp::ClassCsharp do

  before :all do 
    @classCsharp = Languages::Csharp::ClassCsharp.new
  end

  context "When is class without inheritance" do
    it "Ordinary public class declaration." do
      classNameCaptured = @classCsharp.get_class("public class Xpto").name
      expect(classNameCaptured).to eq("Xpto")
    end
    
    it "Ordinary private class declaration." do 
      classNameCaptured = @classCsharp.get_class("private class Xpto").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class declaration with whitespace." do
      classNameCaptured = @classCsharp.get_class("public    class      Xpto").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class declaration between whitespace." do
      classNameCaptured = @classCsharp.get_class("public    class      Xpto   ").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class declaration with whitespace in the beginning." do
      classNameCaptured = @classCsharp.get_class("   public class Xpto").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class declaration with whitespace in the end." do
      classNameCaptured = @classCsharp.get_class("public class Xpto       ").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class declaration delimited by whitespace." do
      classNameCaptured = @classCsharp.get_class(" public class  Xpto      ").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class declaration with a few whitespace." do
      classNameCaptured = @classCsharp.get_class(" public class Xpto  ").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class declaration with whitespace in the beginning." do
      classNameCaptured = @classCsharp.get_class(" public class Xpto").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class declaration ended with whitespace." do
      classNameCaptured = @classCsharp.get_class("public class  Xpto  ").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class declaration with many whitespace." do
      classNameCaptured = @classCsharp.get_class(" public   class  Xpto ").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class declaration with tab." do
      classNameCaptured = @classCsharp.get_class("  public class  Xpto  ").name
      expect(classNameCaptured).to eq("Xpto")
    end
  end

  # context "When with inheritance" do
  #   it "Simple class inheritance." do
  #     classNameCaptured = @classCsharp.get_class("class Xpto < Abc").name
  #     expect(classNameCaptured).to eq("Xpto")
  #   end

  #   it "Class inheritance with whitespace in the beginning." do
  #     classNameCaptured = @classCsharp.get_class("     class   Xpto < Abc").name
  #     expect(classNameCaptured).to eq("Xpto")
  #   end

  #   it "Class inheritance with whitespace between <." do
  #     classNameCaptured = @classCsharp.get_class("class Xpto   < Abc").name
  #     expect(classNameCaptured).to eq("Xpto")
  #   end

  #   it "Class inheritance with many whitespace." do
  #     classNameCaptured = @classCsharp.get_class("   class   Xpto < Abc ").name
  #     expect(classNameCaptured).to eq("Xpto")
  #   end

  #   it "Class inheritance with many whitespace between <." do
  #     classNameCaptured = @classCsharp.get_class("class Xpto      <    Abc").name
  #     expect(classNameCaptured).to eq("Xpto")
  #   end

  #   it "Class inheritance with whitespace in the corners." do
  #     classNameCaptured = @classCsharp.get_class("  class   Xpto < Abc   ").name
  #     expect(classNameCaptured).to eq("Xpto")
  #   end
  # end

  after :all do
    @classCsharp = nil
  end

end
