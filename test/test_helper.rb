require 'simplecov'
SimpleCov.start
require "test/unit"
require "mocha/setup"



SimpleCov.configure do
  minimum_coverage 100
  add_filter "/test/"
end