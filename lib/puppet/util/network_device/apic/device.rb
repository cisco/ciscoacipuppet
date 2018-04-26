require 'puppet/util/network_device/apic'
require 'puppet_x/cisco/restclient'
require 'puppet_x/cisco/aci_provider_utils'
require 'uri'

class Puppet::Util::NetworkDevice::Apic::Device
  attr_accessor :url, :rest, :apicuri, :user, :password, :debug, :session

  def initialize(url, _options = {})
    @url = URI.parse(url)
    @apicuri = '%s://%s' % [@url.scheme, @url.host]
    @user = @url.user
    @password = @url.password
    @debug = _options[:debug]
    @session = nil
    setup_or_refresh_rest_session
  end

  #Setup a REST Session based on the device configuration
  #
  #@return Initialize the @session instance variable
  #@note Lower level exceptions are propagated up the stack
  #
  #@note TBD-1: Add some retry logic and timeout
  #
  def setup_or_refresh_rest_session
    #Once we add retry/timeout logic the content of this method will change
    return unless @session.nil?
    @session = PuppetX::Cisco::APICRestClient.new(url:  @apicuri,
      user: @user,
      password: @password,
      format: 'json',
      debug: @debug )
  end

  #Forward the HTTP POST request to the REST session
  #
  #@param url [String] URL for the POST request
  #@param json_body [ JSON ] JSON string to be used as the payload
  #@return [JSON] Response to the POST request
  #@note Lower level exceptions are propagated up the stack
  #
  def post(url, json_body)
    setup_or_refresh_rest_session
    @session.post(url: url,json_body: json_body)
  end

  #Forward the HTTP GET request to the REST session
  #
  #@param url [String] URL for the GET request
  #@return [JSON] Response to the GET request
  #@note Lower level exceptions are propagated up the stack
  #
  def get(url)
    setup_or_refresh_rest_session
    @session.get(url: url)
  end

  #Forward the HTTP DELETE request to the REST session
  #
  #@param url [String] URL for the DELETE request
  #@return [JSON] Response to the DELETE request
  #@note Lower level exceptions are propagated up the stack
  #
  def delete(url)
    setup_or_refresh_rest_session
    @session.delete(url: url)
  end

  #Forward the Fact request to the APICFacts utility method
  #
  #@return [Hash] custom facts for ACI
  #@note Lower level exceptions are propagated up the stack
  #
  def facts
    setup_or_refresh_rest_session
    PuppetX::Cisco::ACIUtils::get_facts()
  end

end
