module Hubspotter
  class Tracker

    attr_reader :cookie,
                :ip_address,
                :page_url,
                :page_name

    def initialize(args = {})
      @cookie     = args[:cookie]
      @ip_address = args[:ip_address]
      @page_url   = args[:page_url]
      @page_name  = args[:page_name]
    end

    # Public: The Tracker's attributes
    #
    # Returns a Hash
    def attributes
      { :cookie     => cookie,
        :ip_address => ip_address,
        :page_url   => page_url,
        :page_name  => page_name }
    end

  end
end
