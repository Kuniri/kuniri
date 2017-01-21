$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib/kuniri'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'config'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rspec'
require 'coveralls'
require 'faker'

RSpec.configure do |config|
  config.order = 'random'
end

Dir[File.join(File.dirname(__FILE__), "../config/**" , "**.rb")].each do |f|
  require_relative f
end

Dir[File.join(File.dirname(__FILE__), "../lib/kuniri/**" , "**.rb")].each do |f|
  require_relative f
end

Dir[File.join(File.dirname(__FILE__), "./helpers/**" , "**.rb")].each do |f|
  require_relative f
end

Coveralls.wear!
