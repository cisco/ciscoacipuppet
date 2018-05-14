
# March 2018
#
# Copyright (c) 2017-2018  Cisco and/or its affiliates.
#
# Puppet resource provider that allows the administrator to send
# HTTP POST/DELETE operations with specified raw JSON body formed
# according to the specification in the ACI REST Pramming Guide
# [http://cs.co/9002DdJJy]
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

begin
  require 'puppet_x/cisco/aci_provider_utils.rb'
rescue LoadError # seen on master, not on agent
  # See longstanding Puppet issues #4248, #7316, #14073, #14149, etc.
  require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', '..',
                                     'puppet_x', 'cisco', 'aci_provider_utils.rb'))
end

Puppet::Type.type(:cisco_aci_rest).provide(:cisco_aci) do
  desc 'The Cisco provider that allows administrators to
        configure the ACI using REST APIs'

  mk_resource_methods
  attr_reader :property_hash, :property_flush

  # ---------------------------------------------------------------
  # Class Constants
  # ---------------------------------------------------------------

  # Get the namevars for this Puppet Type
  def self.my_namevars
    [
      :name
    ]
  end

  # Get all the namevars for this Puppet Type (includes parents)
  def self.allnamevars
    [
      :name
    ]
  end

  # Get all the properties for this Puppet Type
  def self.allproperties
    [
      :http_request_type,
      :resource_uri,
      :http_request_body,
    ]
  end

  # ---------------------------------------------------------------
  # Puppet Provider Class Methods
  # ---------------------------------------------------------------

  def self.instances
    []
  end # self.instances

  def self.prefetch(resources)
    resources
  end

  # ---------------------------------------------------------------
  # Puppet Provider Instance Methods
  # ---------------------------------------------------------------

  def initialize(value={})
    super(value)
    @property_flush = {}
  end

  def http_request_type=(type)
    # Sets the property_flush with the `http_request_type` from the manifest
    @property_flush[:http_request_type] = type
  end

  def resource_uri=(uri)
    # Sets the property_flush with the `resource_uri` from the manifest
    @property_flush[:resource_uri] = uri
  end

  def http_request_body=(content)
    # Sets the property_flush with the `http_request_body` from the manifest
    @property_flush[:http_request_body] = content
  end

  def flush
    fail ArgumentError, "'http_request_type' is a required property" if @property_flush[:http_request_type].nil?
    url = @property_flush[:resource_uri] + '?rsp-subtree=modified'
    content = @property_flush[:http_request_body]
    if [:post, :default].include? @property_flush[:http_request_type]
      resp = Puppet::Util::NetworkDevice.current.post(url, content)
      puts "Objects changed - #{resp['totalCount']}"
    elsif @property_flush[:http_request_type] == :delete
      Puppet::Util::NetworkDevice.current.delete(url)
    end
  end
end
