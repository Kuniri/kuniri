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

    it "Ordinary scopeless class declaration." do 
      classNameCaptured = @classCsharp.get_class("class Xpto").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Ordinary public partial class declaration." do
      classNameCaptured = @classCsharp.get_class("public partial class Xpto").name
      expect(classNameCaptured).to eq("Xpto")
    end
    
    it "Ordinary private partial class declaration." do 
      classNameCaptured = @classCsharp.get_class("private partial class Xpto").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Ordinary scopeless partial class declaration." do 
      classNameCaptured = @classCsharp.get_class("partial class Xpto").name
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

  context "When with inheritance" do
    it "Simple public class inheritance." do
      classNameCaptured = @classCsharp.get_class("public class Xpto : Abc").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Simple private class inheritance." do
      classNameCaptured = @classCsharp.get_class("private class Xpto : Abc").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Scopeless class inheritance." do
      classNameCaptured = @classCsharp.get_class("class Xpto : Abc").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class inheritance with whitespace in the beginning." do
      classNameCaptured = @classCsharp.get_class("   public  class   Xpto : Abc").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class inheritance with whitespace between <." do
      classNameCaptured = @classCsharp.get_class("public class Xpto   : Abc").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class inheritance with many whitespace." do
      classNameCaptured = @classCsharp.get_class("  public class   Xpto : Abc ").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class inheritance with many whitespace between :." do
      classNameCaptured = @classCsharp.get_class("public class Xpto      :    Abc").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class inheritance with whitespace in the corners." do
      classNameCaptured = @classCsharp.get_class(" public  class   Xpto : Abc   ").name
      expect(classNameCaptured).to eq("Xpto")
    end
  end

  after :all do
    @classCsharp = nil
  end

end
