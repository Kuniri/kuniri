require_relative '../spec_helper'
require 'logger'

RSpec.describe Util::LoggerKuniri do

  context 'Single instance' do
    it 'Object instance should be the same' do
      object1 = Util::LoggerKuniri.create
      object2 = Util::LoggerKuniri.create
      expect(object1).to eq(object2)
    end
  end

  context 'Update log level' do

    before :each do
      Util::LoggerKuniri.create
    end

    it 'Default log level' do
      expect(Util::LoggerKuniri.create.level).to eq(Logger::WARN)
    end

    it 'Error log level' do
      Util::LoggerKuniri.update_log_level(Logger::ERROR)
      expect(Util::LoggerKuniri.create.level).to eq(Logger::ERROR)
    end

    it 'Info log level' do
      Util::LoggerKuniri.update_log_level(Logger::INFO)
      expect(Util::LoggerKuniri.create.level).to eq(Logger::INFO)
    end

    it 'Warn log level' do
      Util::LoggerKuniri.update_log_level(Logger::WARN)
      expect(Util::LoggerKuniri.create.level).to eq(Logger::WARN)
    end

    it 'Fatal log level' do
      Util::LoggerKuniri.update_log_level(Logger::FATAL)
      expect(Util::LoggerKuniri.create.level).to eq(Logger::FATAL)
    end

    after :each do
      Util::LoggerKuniri.update_log_output(STDOUT)
    end
  end

  context 'Update output log' do
  end

  context 'Verify log methods' do
    it 'Should not call undefined method' do
      pending 'Not implemented yet'
    end
  end

end
