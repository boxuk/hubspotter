# Hubspotter

[![Code Climate](https://codeclimate.com/repos/51d3f7b313d63737290591d9/badges/ca9949c31727181a4f7f/gpa.png)](https://codeclimate.com/repos/51d3f7b313d63737290591d9/feed) [![Build Status](https://travis-ci.org/boxuk/hubspotter.png?branch=master)](https://travis-ci.org/boxuk/hubspotter) [![Coverage Status](https://coveralls.io/repos/boxuk/hubspotter/badge.png?branch=master)](https://coveralls.io/r/boxuk/hubspotter?branch=master)

> Provides a simple Ruby wrapper for adding Contacts using the Forms API.

## Usage

Add `config/initializers/hubspotter.rb` to your project and add the following:

    Hubspotter.configure do |config|
      config.portal_id = HUBSPOTTER_ACCOUNT_ID
      config.form_id   = FORM_UUID
    end

Create a Contact with a Hash of params for the Contact:
*(You probably want to do this in a `create` action of a User controller.)*

    contact = Hubspotter::Contact.new(firstname: 'Max', lastname: 'Woolf', email: 'example@example.com', key: value....)
    contact.create
    => #<HTTParty::Response:0x8 parsed_response=nil, @response=#<Net::HTTPNoContent 204 No Content readbody=true>, @headers={"access-control-allow-credentials"=>["false"], "date"=>["Wed, 03 Jul 2013 13:36:28 GMT"], "server"=>["Apache-Coyote/1.1"], "connection"=>["Close"]}> 

It will return a HTTParty response with code 204 if successful.

*Since this Gem calls a 3rd party API, we reccomend you use a background job library such as Delayed Job.*