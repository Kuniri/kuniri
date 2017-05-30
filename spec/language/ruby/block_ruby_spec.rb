require_relative '../../spec_helper'

RSpec.describe Languages::Ruby::BlockRuby do

  before :each do
    @blockRuby = Languages::Ruby::BlockRuby.new
  end

  context 'Simple block detection:' do
    it 'Detect each' do
      captured = @blockRuby.get_block('xpto.each do |y|')
      expect(captured.expression).to eq('EACH')
    end

    it 'Detect map' do
      captured = @blockRuby.get_block('xpto.map do |y|')
      expect(captured.expression).to eq('MAP')
    end

    it 'Detect each' do
      captured = @blockRuby.get_block('xpto.collect do |y|')
      expect(captured.expression).to eq('COLLECT')
    end

    it 'Detect delete if' do
      captured = @blockRuby.get_block('xpto.delete_if do |y|')
      expect(captured.expression).to eq('DELETE_IF')
    end

    it 'Detect delete at' do
      captured = @blockRuby.get_block('xpto.delete_at do |y|')
      expect(captured.expression).to eq('DELETE_AT')
    end

    it 'Detect each with index' do
      captured = @blockRuby.get_block('xpto.each_with_index do |y|')
      expect(captured.expression).to eq('EACH_WITH_INDEX')
    end

    it 'Detect each with as attribute' do
      captured = @blockRuby.get_block('@xpto.each_with_index do |y|')
      expect(captured.expression).to eq('EACH_WITH_INDEX')
    end

    it 'Detect each with as class object' do
      captured = @blockRuby.get_block('@@xpto.each_with_index do |y|')
      expect(captured.expression).to eq('EACH_WITH_INDEX')
    end

  end

  context 'Check different situations:' do
    it 'Check block with white space in the beginning' do
      captured = @blockRuby.get_block('xpto.              each do |y|')
      expect(captured.expression).to eq('EACH')
    end

    it 'Check block with white space at the end' do
      captured = @blockRuby.get_block('xpto.each      do    |u|    ')
      expect(captured.expression).to eq('EACH')
    end

    it 'Check block with white space between parameters' do
      captured = @blockRuby.get_block('xpto.map do |         uuuu         |')
      expect(captured.expression).to eq('MAP')
    end

    it 'Check block with multiple white spaces' do
      captured = @blockRuby.get_block('    xpto .  collect    do  |u | ')
      expect(captured.expression).to eq('COLLECT')
    end

    it 'Nested access' do
      captured = @blockRuby.get_block('lalala.huehue.xpto.each do |y|')
      expect(captured.expression).to eq('EACH')
    end

  end

  context 'Different but valid way to call iterators:' do
    it 'With number' do
      captured = @blockRuby.get_block('3.times do |lalala|')
      expect(captured.expression).to eq('TIMES')
    end

    it 'With big number' do
      captured = @blockRuby.get_block('332432.times do |lalala|')
      expect(captured.expression).to eq('TIMES')
    end
  end

  context 'Try to detect lambda: ' do
    it 'Simple lambda' do
      captured = @blockRuby.get_block('lambda do')
      expect(captured.type).to eq('LAMBDABLOCK')
    end

    it 'Simple lambda with space between' do
      captured = @blockRuby.get_block('   lambda    do  ')
      expect(captured.type).to eq('LAMBDABLOCK')
    end

    it 'Simple lambda with assignment' do
      captured = @blockRuby.get_block('xpto = lambda do')
      expect(captured.type).to eq('LAMBDABLOCK')
    end

    it 'Lambda with spaces in the begining' do
      captured = @blockRuby.get_block('     lambda do')
      expect(captured.type).to eq('LAMBDABLOCK')
    end

    it 'Lambda with spaces in the end' do
      captured = @blockRuby.get_block('lambda       do    ')
      expect(captured.type).to eq('LAMBDABLOCK')
    end

    it 'Lambda with a single parameters' do
      captured = @blockRuby.get_block('lambda do |x|')
      expect(captured.type).to eq('LAMBDABLOCK')
    end

    it 'Lambda with a multiple parameters' do
      captured = @blockRuby.get_block('lambda do |x, y, la, xpto, kx_2|')
      expect(captured.type).to eq('LAMBDABLOCK')
    end

    it 'Lambda with a multiple parameters and space' do
      captured = @blockRuby.get_block(' lambda  do  |  x,    la, kx_2 |  ')
      expect(captured.type).to eq('LAMBDABLOCK')
    end

    it 'Simple lambda with {}' do
      captured = @blockRuby.get_block('lambda { puts 3 }')
      expect(captured.type).to eq('LAMBDABLOCK')
    end

    it 'Simple lambda with {} and without space' do
      captured = @blockRuby.get_block('lambda{ puts 3 }')
      expect(captured.type).to eq('LAMBDABLOCK')
    end

    it 'Special lambda syntax' do
      captured = @blockRuby.get_block('->() { puts 5 }')
      expect(captured.type).to eq('LAMBDABLOCK')
    end

    it 'Special lambda syntax with single parameter' do
      captured = @blockRuby.get_block('->(x) { puts 5 }')
      expect(captured.type).to eq('LAMBDABLOCK')
    end

    it 'special lambda syntax with multiple parameter' do
      captured = @blockRuby.get_block('->(x, y, lkjk, jk_32) { puts 5 }')
      expect(captured.type).to eq('LAMBDABLOCK')
    end

    it 'special lambda syntax with multiple parameter and spaces' do
      captured = @blockRuby.get_block(' -> ( x, y ,  lk,  jk_32  ) { puts 5 }')
      expect(captured.type).to eq('LAMBDABLOCK')
    end

  end

  context 'Should not detect lambda:' do
    it 'Not the same reserved word' do
      captured = @blockRuby.get_block('LAMBDA do')
      expect(captured).to eq(nil)
    end

    it 'Should not detect lambda inside quotes' do
      captured = @blockRuby.get_block('\"lambda do\"')
      expect(captured).to eq(nil)
    end

    it 'Should not detect lambda and do without space' do
      captured = @blockRuby.get_block('lambdado')
      expect(captured).to eq(nil)
    end

    # TODO: After implement pre-parse, revive this test
    #it 'Should not detect lambda with do and {' do
    #  captured = @blockRuby.get_block('lambda do { puts 3 }')
    #  expect(captured).to eq(nil)
    #end

  end

  context 'Should not detect:' do
    it 'Only iterator' do
      captured = @blockRuby.get_block('each do |y|')
      expect(captured).to eq(nil)
    end

    it 'Only full syntax' do
      captured = @blockRuby.get_block('xpto.each do')
      expect(captured).to eq(nil)
    end

    it "Syntax error with '|'" do
      captured = @blockRuby.get_block('xpto..each do |x')
      expect(captured).to eq(nil)
    end

    it "Syntax error with ','" do
      captured = @blockRuby.get_block('xpto,each do |x|')
      expect(captured).to eq(nil)
    end

    it 'Code inside simple quotas' do
      captured = @blockRuby.get_block("'xpto.each do |x|'")
      expect(captured).to eq(nil)
    end

    it 'Code inside double quotes' do
      captured = @blockRuby.get_block("\"xpto.each do |x|\"")
      expect(captured).to eq(nil)
    end

    it 'Code inside double quotes with spaces' do
      captured = @blockRuby.get_block("    \"      xpto.each do |x|\"   ")
      expect(captured).to eq(nil)
    end

    it 'Block inside puts' do
      captured = @blockRuby.get_block("puts 'something_like_block.each do |number|'")
      captured.inspect
      expect(captured).to eq(nil)
    end

    it 'Block inside puts with spaces' do
      captured = @blockRuby.get_block("   puts  '   something_like_block.each do |number|'")
      captured.inspect
      expect(captured).to eq(nil)
    end

  end

  after :each do
    @blockRuby = nil
  end

end
