require_relative '../spec_helper'

RSpec.describe Parser::OutputFormat do

  before :all do
    @outputFormat = Parser::OutputFormat.new
  end

  context "Cannot call unimplemented method." do

   # it "Create all data" do
   #   expect{@outputFormat.create_data(nil)}.to raise_error(
   #           NotImplementedError)
   # end

    it "Generate class" do
      expect{@outputFormat.class_generate(nil)}.to raise_error(
              NotImplementedError)
    end

    it "Generate constructor" do
      expect{@outputFormat.constructor_generate(nil)}.to raise_error(
              NotImplementedError)
    end

    it "Generate inheritance" do
      expect{@outputFormat.inheritance_generate(nil)}.to raise_error(
              NotImplementedError)
    end

    it "Generate method" do
      expect{@outputFormat.method_generate(nil)}.to raise_error(
              NotImplementedError)
    end

    it "Generate parameters" do
      expect{@outputFormat.parameters_generate(nil)}.to raise_error(
              NotImplementedError)
    end

    it "Generate attribute" do
      expect{@outputFormat.attribute_generate(nil)}.to raise_error(
              NotImplementedError)
    end

    it "Generate function" do
      expect{@outputFormat.function_generate(nil)}.to raise_error(
              NotImplementedError)
    end

    it "Generate global variable" do
      expect{@outputFormat.global_variable_generate(nil)}.to raise_error(
              NotImplementedError)
    end

    it "Generate require" do
      expect{@outputFormat.extern_requirement_generate(nil)}.to raise_error(
              NotImplementedError)
    end

    it "Generate repetition" do
      expect{@outputFormat.repetition_generate(nil)}.to raise_error(
              NotImplementedError)
    end

    it "Generate conditional" do
      expect{@outputFormat.conditional_generate(nil)}.to raise_error(
              NotImplementedError)
    end

  end

  after :all do
    @outputFormat = nil
  end

end
