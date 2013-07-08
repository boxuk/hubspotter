require 'test_helper'

class Hubspotter::DonorTest < Test::Unit::TestCase

  def setup
    @tracking_details = { :cookie     => '60c2ccdfe4892f0fa0593940b12c11aa',
                          :ip_address => '192.168.1.12',
                          :page_url   => 'http://demo.hubapi.com/contact/',
                          :page_name  => 'Contact Us' }

    @tracker = Hubspotter::Tracker.new(@tracking_details)
  end

  def test_cookie_returns_the_tracking_cookie
    assert_equal @tracking_details[:cookie], @tracker.cookie
  end

  def test_ip_address_returns_the_ip_address
    assert_equal @tracking_details[:ip_address], @tracker.ip_address
  end

  def test_page_url_returns_the_page_url
    assert_equal @tracking_details[:page_url], @tracker.page_url
  end

  def test_page_name_returns_the_page_name
    assert_equal @tracking_details[:page_name], @tracker.page_name
  end

  def test_attributes_returns_all_values_as_a_hash
    assert_equal @tracking_details, @tracker.attributes
  end

end
