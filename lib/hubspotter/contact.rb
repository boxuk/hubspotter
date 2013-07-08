module Hubspotter
  class Contact

    require 'json'
    require 'httparty'
    require "addressable/uri"

    CREATE_CONTACT_FORM_ID    = ''
    UPDATE_CONTACT_FORM_ID    = ''

    BASE_URI = "https://forms.hubspot.com/uploads/form/v2/"
    HEADERS  =  { 'Content-Type' => 'application/x-www-form-urlencoded' }

    attr_reader :properties,
                :hutk,
                :ip_address,
                :page_url,
                :page_name

    # Public: Initialize a new HubSpot Contact
    #
    # properties       - Hash of personal information (default: {})
    #                    { :fieldname => 'value', ... }
    #
    # tracking_details - Hash of HubSpot tracking information (optional)
    #                    :hutk       - HubSpot Tracking Cookie
    #                    :ip_address - String IP address of the user
    #                    :page_url   - String url of the page the Contact was
    #                                  initialized
    #                    :page_name  - String name of the page the Contact was
    #                                  initialized
    #
    # Example
    #
    #   # Create a HubSpot contact
    #   contact = Hubspotter::Contact(hubspot_properties, tracking_details)
    #
    #   if contact.create
    #     # Handle success
    #   else
    #     # Handle failure
    #   end
    #
    # Returns a Hubspotter::Contact
    def initialize(properties, tracking_details = {})
      @properties  = properties
      @hutk        = tracking_details[:hutk]
      @ip_address  = tracking_details[:ip_address]
      @page_url    = tracking_details[:page_url]
      @page_name   = tracking_details[:page_name]
    end

    # Public: Submit the details to HubSpot to create a new Contact
    #
    # Returns a Boolean
    def create
      HTTParty.post(create_url, :options => { :headers => HEADERS })
    end

    # Public: Submit the details to HubSpot to update an existing Contact
    #
    # Returns a Boolean
    def update
      HTTParty.post(update_endpoint, :body => properties).success?
    end

    # Internal: Entire URL when creating a Contact
    #
    # Returns a String
    def create_url
      uri = Addressable::URI.new
      uri.query_values = properties
      "#{ BASE_URI }#{ Hubspotter.configuration.portal_id }#{ create_endpoint }#{ uri.query }"
    end

    private

    # Internal: The endpoint to POST to when creating a Contact
    #
    # Returns a String
    def create_endpoint
      "/#{ Hubspotter.configuration.form_id }?"
    end

    # Internal: The endpoint to POST to when updating a Contact
    #
    # Returns a String
    def update_endpoint
      "/#{ UPDATE_CONTACT_FORM_ID }"
    end


  end
end
