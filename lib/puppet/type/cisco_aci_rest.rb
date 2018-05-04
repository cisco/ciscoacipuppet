#
# February 2018
#
# Copyright (c) 2017-2018 Cisco and/or its affiliates.
#
# Puppet resource type that allows the administrator to send
# HTTP POST/DELETE operations with specified raw JSON body formed
# according to the specification in the ACI REST Programming Guide
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

Puppet::Type.newtype(:cisco_aci_rest) do
  @doc = "Configures ACI using REST APIs

  cisco_aci_rest { '<aci-title>':
    ..attributes..
  }

  '<aci-title>' is the title of the aci_rest resource.

  Note: The cisco_aci_rest module only supports configuration of the devices.
        Querying the device for the current state is not supported.

  Example:
    cisco_aci_rest {'configure_tenant':
      http_request_type => post,
      resource_uri      => '/api/mo/uni.json',
      http_request_body => '{
          \"fvTenant\": {
              \"attributes\": {
                  \"name\": \"puppet_test\"
              }
          }
      }',
    }
  "

  apply_to_device

  def self.title_patterns
    identity = ->(x) { x }
    patterns = []

    patterns << [
      /^(\S+)$/,
      [
        [:name, identity]
      ],
    ]
    patterns
  end

  # ---------------------------------------------------------------
  # Namevars
  # ---------------------------------------------------------------

  newparam(:name, namevar: true) do
    desc 'Name of the cisco_aci_rest resource'
  end

  # ---------------------------------------------------------------
  # Properties
  # ---------------------------------------------------------------

  newproperty(:http_request_type) do
    desc "HTTP request methods to perform operations on objects.
          Valid choices are post, delete and default. post is the
          default value."
    newvalues(:post, :delete, :default)
  end

  newproperty(:resource_uri) do
    desc "URI being used to execute API calls. Only JSON format is
          supported. Eg: '/api/mo/uni.json'."
    validate do |uri|
      fail 'Only JSON URIs are supported' unless uri.end_with? '.json'
    end
  end

  newproperty(:http_request_body) do
    desc 'Configuration of the ACI MO in json format.

    Example:

      {
          "fvTenant": {
              "attributes": {
                  "name": "puppet_test"
              }
          }
      }
    '
  end
end
