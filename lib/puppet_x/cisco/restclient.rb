require 'httpclient'
require 'openssl'
require 'nokogiri'
require 'json'
module PuppetX
  module Cisco
    # REST client end point implementation is borrowed from ACIrb and
    # modified for our usecase
    class APICRestClient
      attr_accessor :format, :user, :password, :baseurl, :debug, :verify
      attr_reader :auth_cookie, :refresh_time

      class ApicAuthenticationError < StandardError
      end

      class ApicErrorResponse < StandardError
      end

      # Initializes and establishes an authenticated session with APIC
      # EST endpoint
      # Note: This method is used as is from the ACIrb Gem
      #
      # @parm options [Hash] options used to specify connectivity attributes
      # (default: {}):
      #
      #           :url - string URL of APIC, e.g., https://apic (required)
      #           :user - string containing User ID for authentication (required)
      #           :password - string containing Password for
      #                       authentication (required)
      #           :debug - boolean true or false for including verbose REST output
      #                    (default: false)
      #           :format - string 'xml' or 'json' specifying the format to use
      #                     for messaging to APIC. (default: xml)
      #           :verify - boolean true or false for verifying the SSL
      #                     certificate. (default: false)
      #
      # @example rest = RestClient.new(url: 'https://apic', user: 'admin',
      #                          password: 'password', format: 'json',
      #                          debug: false)
      #
      def initialize(options={})
        uri = URI.parse(options[:url])
        @baseurl = "#{uri.scheme}://#{uri.host}:#{uri.port}"
        @format = options[:format] ? options[:format] : 'xml'
        @user = options[:user]
        @password = options[:password]
        @verify = options[:verify]
        @client = HTTPClient.new
        @client.ssl_config.verify_mode = OpenSSL::SSL::VERIFY_NONE \
          unless options[:verify] && uri.scheme == 'https'
        @debug = options[:debug]
        @auth_cookie = ''

        authenticate if @user && @password
      end

      # Authenticates the REST session with APIC
      # Note: This method is used as is from the ACIrb Gem
      #
      # Sends a aaaLogin message to APIC and updates the following instance
      # variables:
      #   @auth_cookie - session cookie
      #   @refresh_time - session refresh timeout in seconds
      #
      # Returns nothing.
      #
      def authenticate
        builder = Nokogiri::XML::Builder.new do |xml|
          xml.aaaUser(name: @user, pwd: @password)
        end
        post_url = URI.encode(@baseurl.to_s + '/api/mo/aaaLogin.xml')
        puts 'POST REQUEST', post_url if @debug
        puts 'POST BODY', builder.to_xml if @debug
        puts 'Initiating authentication with APIC'
        response = @client.post(post_url, body: builder.to_xml)
        puts 'POST RESPONSE: ', response.body if @debug
        doc = Nokogiri::XML(response.body)
        fail ApicAuthenticationError,
             sprintf('Authentication error(%s): %s',
                     doc.at_css('error')['code'], doc.at_css('error')['text']) \
          if doc.at_css('error')
        fail ApicErrorResponse,
             sprintf('Unexpected HTTP Error response code(%s): %s',
                     response.code, response.body) if response.code != 200
        @auth_cookie = doc.at_css('aaaLogin')['token']
        @refresh_time = doc.at_css('aaaLogin')['refreshTimeoutSeconds']
      end

      # Public: Refreshes an existing RestClient object session
      # Sends a aaaRefresh message to APIC and updates the following instance
      # variables:
      #   @auth_cookie - session cookie
      #   @refresh_time - session refresh timeout in seconds
      #
      # Note: This method is used as is from the ACIrb Gem
      #
      # Returns nothing.
      #
      def refresh_session
        get_url = URI.encode(@baseurl.to_s + '/api/mo/aaaRefresh.xml')
        puts 'GET REQUEST', get_url if @debug
        response = @client.get(get_url)
        puts 'GET RESPONSE: ', response.body if @debug
        doc = Nokogiri::XML(response.body)
        fail ApicAuthenticationError,
             sprintf('Authentication error(%s): %s', doc.at_css('error')['code'],
                     doc.at_css('error')['text']) \
          if doc.at_css('error')
        @auth_cookie = doc.at_css('aaaLogin')['token']
        @refresh_time = doc.at_css('aaaLogin')['refreshTimeoutSeconds']
      end

      # Internal: Escape URI before using with APIC REST interface
      # Note: This method is used as is from the ACIrb Gem
      #
      # @param uri [String] - URI to escape
      #
      # Returns escaped URI as string
      #
      def escape(uri)
        URI.encode(uri, %r{[^\-_.!~*'()a-zA-Z\d;\/?:@&=+$,]})
      end

      # Posts data to the APIC REST interface
      # Note: This method is from ACIrb, only the arguments are modified to
      # for our usecase
      #
      # @param url [String] - relative URL for request (required)
      # @param json_body [ JSON] - post payload to be included in the request
      #
      # Returns results of POST after parsing for error
      #
      def post(url:, json_body:)
        post_url = escape(@baseurl.to_s + url.to_s)

        puts 'POST REQUEST', post_url if @debug
        puts 'POST BODY', json_body if @debug
        response = @client.post(post_url, body: json_body)
        puts 'POST RESPONSE: ', response.body if @debug

        parse_response(response)
      end

      # Queries the APIC REST API for data
      # Note: This method is from ACIrb, only the arguments are modified to
      # for our usecase
      #
      # @param url [ String] - relative URL for request
      # Returns results of POST after parsing for error
      #
      def get(url:)
        get_url = escape(@baseurl.to_s + url.to_s)

        puts 'GET REQUEST', get_url if @debug
        response = @client.get(get_url)
        puts 'GET RESPONSE: ', response.body if @debug

        parse_response(response)
      end

      # Internal: Parses for error responses in APIC response payload
      #
      # Note-1: This method is from ACIrb. It has been modified to handle
      # only JSON payload
      #
      # Note-2: This method will be modified to adapt for Puppet usecase
      #
      # @param doc [JSON] - Nokigiri JSON document or Hash array containing
      #                     well formed APIC response payload (required)
      #
      def parse_error(doc)
        fail ApicErrorResponse,
             sprintf('Error response from APIC (%s): "%s"',
                     doc['imdata'][0]['error']['attributes']['code'].to_s,
                     doc['imdata'][0]['error']['attributes']['text'].to_s) \
          if doc['imdata'].length > 0 && doc['imdata'][0].include?('error')
      end

      # Parse response from APIC for errors and return JSON payload
      # Note: This is a work-in-progress. Orginal logic from ACIrb was modified
      # to handle the following. We need to handle only the JSON format and
      # return the JSON attributes as is
      #
      # @param response [JSON] JSON response from APIC
      #
      def parse_response(response)
        # Assume JSON response
        json_data = response.body
        doc = JSON.parse(json_data)
        parse_error(doc)
        doc
      end

      # Delete MO identified by url
      #
      # @param url [String] URL for MO instance to be deleted
      #
      def delete(url:)
        delete_url = escape(@baseurl.to_s + url.to_s)

        puts 'DELETE REQUEST', delete_url if @debug
        response = @client.delete(delete_url)
        puts 'DELETE RESPONSE: ', response.body if @debug

        parse_response(response)
      end
    end
  end
end
