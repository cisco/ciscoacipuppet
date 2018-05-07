#
# March 2018
#
# Copyright (c) 2017-2018 Cisco and/or its affiliates.
#
# Sample Puppet manifest to demonstrate cisco_aci_rest
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

#
# Wrapper class that uses component classes and hiera data to test
# provisioning of the resources defined in the module. It provides
# an optional parameter 'override_ensure' to that overrides the hiera data
# related to the ensure parameter.
#
# Example-1: When no parameter is specified hiera data will be used
# Example-2: When parameter override_method=>"delete", component classes will
# use all the data from the hiera, except method. This allows one
# to test the provisioning of all the resources, without having to
# modify the hiera yaml
#
#
class cisco_aci::classes::cisco_aci_rest_only (
    $override_http_request_type = undef,
    $override_resource_uri = undef,
    $override_http_request_body = undef
  ) {
  class {'cisco_aci::classes::cisco_aci_rest':
    override_http_request_type => $override_http_request_type,
    override_resource_uri      => $override_resource_uri,
    override_http_request_body => $override_http_request_body
  }
}
