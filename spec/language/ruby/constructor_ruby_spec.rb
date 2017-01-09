require_relative '../../spec_helper'

RSpec.describe Languages::Ruby::ConstructorRuby do

  before :all do
    @constructor = Languages::Ruby::ConstructorRuby.new
  end

  context 'When constructor without parameter' do
    it 'Simple declaration' do
      input = 'def initialize'
      expect(@constructor.get_constructor(input).name).to eq('initialize')
    end

    it 'With spaces in the begin' do
      input = '         def initialize'
      expect(@constructor.get_constructor(input).name).to eq('initialize')
    end

    it 'With spaces in the begin and between initialize' do
      input = '        def     initialize'
      expect(@constructor.get_constructor(input).name).to eq('initialize')
      input = '                 def             initialize'
      expect(@constructor.get_constructor(input).name).to eq('initialize')
    end

    it 'With spaces in the end' do
      input = 'def initialize                   '
      expect(@constructor.get_constructor(input).name).to eq('initialize')
      input = 'def              initialize                   '
      expect(@constructor.get_constructor(input).name).to eq('initialize')
    end

    it 'With spaces in both sides' do
      input = '           def             initialize              '
      expect(@constructor.get_constructor(input).name).to eq('initialize')
    end

    it 'No constructor' do
      input = '   def methodX'
      expect(@constructor.get_constructor(input)).to eq(nil)
    end
  end

  context 'When constructor with parameters' do
    # TODO
  end

  context 'Using initialize in the name, but is not a constructor' do
    it 'Something after initialize name that is not a constructor' do
      input = 'def initialize_xpto'
      expect(@constructor.get_constructor(input)).to eq(nil)
    end

    it 'Something after initialize name, with spaces' do
      input = '   def     initialize_noooo_noooo    '
      expect(@constructor.get_constructor(input)).to eq(nil)
    end

    it 'Something before initialize name' do
      input = 'def xpto_initialize'
      expect(@constructor.get_constructor(input)).to eq(nil)
    end

    it 'Something before initialize name with spaces' do
      input = '     def     abc_xpto_initialize   '
      expect(@constructor.get_constructor(input)).to eq(nil)
    end

    it 'Something after initialize name with parameters' do
      input = 'def initialize_xpto(abc, xyz)'
      expect(@constructor.get_constructor(input)).to eq(nil)
    end

    it 'Something after initialize name, with spaces and parameters' do
      input = '   def       initialize_xpto      ( abc  ,   xyz  )  '
      expect(@constructor.get_constructor(input)).to eq(nil)
    end

    it 'Something before initialize name with parameters' do
      input = 'def abc_initialize(abc, xyz)'
      expect(@constructor.get_constructor(input)).to eq(nil)
    end

    it 'Something before initialize name with parameters and spaces' do
      input = '     def     bla_abc_initialize  (   abc , xyz     )     '
      expect(@constructor.get_constructor(input)).to eq(nil)
    end

    it 'Something between initialize name' do
      input = 'def xpto_initialize_abc'
      expect(@constructor.get_constructor(input)).to eq(nil)
    end

    it 'Something between initialize name with spaces' do
      input = '   def     xpto_initialize_abc     '
      expect(@constructor.get_constructor(input)).to eq(nil)
    end

    it 'Something between initialize name, with parameters' do
      input = 'def xpto_initialize_abc(aaaa, uuuuu, cccc, dddd)'
      expect(@constructor.get_constructor(input)).to eq(nil)
    end

    it 'Something between initialize name, with parameters and spaces' do
      input = ' def     xpto_initialize_abc  (    aaaa, uuuuu, cccc  ,   dddd)'
      expect(@constructor.get_constructor(input)).to eq(nil)
    end
  end

  after :all do
    @constructor = nil
  end
end
