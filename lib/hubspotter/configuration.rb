module Hubspotter

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :portal_id, :form_id

    def initialize(portal_id = nil, form_id = nil)
      @portal_id = portal_id
      @form_id   = form_id
    end

  end
end
