$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib/kuniri'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'config'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
#require "codeclimate-test-reporter"
#CodeClimate::TestReporter.start
require 'rspec'
require 'simplecov'

if ENV['CI']
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
else
  require 'simplecov'
  SimpleCov.start
end

SimpleCov.start

RSpec.configure do |config|
  config.order = 'random'
end

Dir[File.join(File.dirname(__FILE__), "../config/**" , "**.rb")].each do |f|
  require_relative f
end

Dir[File.join(File.dirname(__FILE__), "../lib/kuniri/**" , "**.rb")].each do |f|
  require_relative f
end
