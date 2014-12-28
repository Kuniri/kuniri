$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'app'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'config'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'

RSpec.configure do |config|
  config.order = 'random'
end

Dir[File.join(File.dirname(__FILE__), "../config/**" , "**.rb")].each do |f|
  require_relative f
end

Dir[File.join(File.dirname(__FILE__), "../app/**" , "**.rb")].each do |f|
  require_relative f
end
