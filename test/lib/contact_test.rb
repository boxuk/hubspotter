require 'test_helper'
require 'hubspotter'

class Hubspotter::ContactTest < Test::Unit::TestCase

  def setup

    Hubspotter.configure do |config|
      config.portal_id = 292088
      config.form_id   = '5bc360e3-a605-42fa-8a17-a230bf7d0f46'
    end

    # String params that get sent to HubSpot
    # Note the camelCase / no underscore keys
    @valid_params = {
      :firstname         => 'TestContact',
      :lastname          => 'FormSub',
      :email             => 'formsub@hubspot.com',
      :blah              => 'blah',
      :hs_context        => { :hutk      => '60c2ccdfe4892f0fa0593940b12c11aa',
                              :ipAddress => '192.168.1.12',
                              :pageUrl   => 'http://demo.hubapi.com/contact/',
                              :pageName  => 'Contact Us' }.to_json
    }

    # Valid contact details that can be given to Hubspotter::Contact initializer
    @contact_details = { :firstname  => 'TestContact',
                         :lastname   => 'FormSub',
                         :email       => 'formsub@hubspot.com' }

    # Valid tracking details that can be given to Hubspotter::Contact initializer
    @tracking_details = { :hutk       => '60c2ccdfe4892f0fa0593940b12c11aa',
                          :ip_address => '192.168.1.12',
                          :page_url   => 'http://demo.hubapi.com/contact/',
                          :page_name  => 'Contact Us' }

    # A valid Hubspotter::Contact
    @contact = Hubspotter::Contact.new(@contact_details, @tracking_details)

    # Mocked HubSpot Responses
    @success   = OpenStruct.new(:code => 204, :success? => true)
    @not_found = OpenStruct.new(:code => 404, :success? => false)
    @error     = OpenStruct.new(:code => 500, :success? => false)
  end

  # def test_it_can_make_http_requests
  #   assert Hubspotter::Contact.include?(HTTParty)
  # end

  def test_it_communicates_only_with_the_HubSpot_API
    expected = 'https://forms.hubspot.com/uploads/form/v2/'
    assert_equal expected, Hubspotter::Contact::BASE_URI
  end

  def test_it_sends_data_as_x_www_form_urlencoded
    expected = 'application/x-www-form-urlencoded'
    assert_equal expected, Hubspotter::Contact::HEADERS['Content-Type']
  end

  def test_it_has_a_first_name
    expected = @contact_details[:first_name]
    assert_equal expected, @contact.properties[:first_name]
  end

  def test_it_has_a_last_name
    expected = @contact_details[:last_name]
    assert_equal expected, @contact.properties[:last_name]
  end

  def test_it_has_an_email
    expected = @contact_details[:email]
    assert_equal expected, @contact.properties[:email]
  end

  def test_it_has_a_blah
    expected = @contact_details[:blah]
    assert_equal expected, @contact.properties[:blah]
  end

  def test_it_has_a_hubspot_tracking_cookie
    expected = @tracking_details[:hutk]
    assert_equal expected, @contact.hutk
  end

  def test_it_has_an_ip_address
    expected = @tracking_details[:ip_address]
    assert_equal expected, @contact.ip_address
  end

  def test_it_has_a_page_url
    expected = @tracking_details[:page_url]
    assert_equal expected, @contact.page_url
  end

  def test_it_has_a_page_name
    expected = @tracking_details[:page_name]
    assert_equal expected, @contact.page_name
  end

    def test_create_submits_the_contact_to_hubspot
      HTTParty.
        expects(:post).
          with('https://forms.hubspot.com/uploads/form/v2/292088/5bc360e3-a605-42fa-8a17-a230bf7d0f46?email=formsub%40hubspot.com&firstname=TestContact&lastname=FormSub', {:options => {:headers => {'Content-Type' => 'application/x-www-form-urlencoded'}}}).
            returns(@success)

      @contact.create
    end

    def test_create_successfully_creates_a_contact
      HTTParty.expects(:post).returns(@success)
      assert_equal @success, @contact.create
    end

    def test_create_posts_to_an_incorrect_form
      HTTParty.expects(:post).returns(@not_found)
      assert_equal @not_found, @contact.create
    end

    def test_create_unsuccessfully_creates_a_contact
      HTTParty.expects(:post).returns(@error)
      assert_equal @error, @contact.create
    end

    def test_create_url_returns_a_string
      assert_equal "https://forms.hubspot.com/uploads/form/v2/292088/5bc360e3-a605-42fa-8a17-a230bf7d0f46?email=formsub%40hubspot.com&firstname=TestContact&lastname=FormSub", @contact.create_url
    end


end
