require 'test_helper'
require 'hubspotter'

class Hubspotter::ContactTest < Test::Unit::TestCase

  def test_creating_a_new_configuration
    Hubspotter.configure do |config|
      config.portal_id = 100
      config.form_id = 'abcde'
    end

    assert_equal 100, Hubspotter.configuration.portal_id
    assert_equal 'abcde', Hubspotter.configuration.form_id
  end

  def test_creating_a_new_configuration_without_a_block
    Hubspotter::Configuration.new(12345, 'abcde')
  end

end