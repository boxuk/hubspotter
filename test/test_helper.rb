require 'simplecov'
SimpleCov.start
require 'coveralls'
Coveralls.wear!
require "test/unit"
require "mocha/setup"



SimpleCov.configure do
  minimum_coverage 100
  add_filter "/test/"
end